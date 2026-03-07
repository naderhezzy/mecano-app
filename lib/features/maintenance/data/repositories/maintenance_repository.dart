import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mecano_app/core/errors/app_exception.dart';
import 'package:mecano_app/core/typedefs/typedefs.dart';
import 'package:mecano_app/database/app_database.dart';
import 'package:mecano_app/features/maintenance/domain/models/maintenance_record.dart';
import 'package:mecano_app/shared/providers/database_provider.dart';
import 'package:mecano_app/shared/providers/supabase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

part 'maintenance_repository.g.dart';

class MaintenanceRepository {
  const MaintenanceRepository(this._client, this._db);

  final supabase.SupabaseClient _client;
  final AppDatabase _db;

  /// Watches maintenance records for a vehicle from local Drift DB.
  /// Also triggers a background Supabase fetch to keep the cache fresh.
  Stream<List<MaintenanceRecord>> watchMaintenanceForVehicle(String vehicleId) {
    // Fire a background fetch from Supabase to refresh local cache
    _fetchAndCacheFromRemote(vehicleId);

    final query = _db.select(_db.maintenanceRecordsTable)
      ..where((t) => t.vehicleId.equals(vehicleId))
      ..orderBy([(t) => OrderingTerm.desc(t.serviceDate)]);

    return query.watch().map(
          (rows) => rows.map(_mapRowToRecord).toList(),
        );
  }

  /// Adds a new maintenance record: writes to local Drift first,
  /// then pushes to Supabase.
  FutureEither<MaintenanceRecord> addMaintenanceRecord(
    MaintenanceRecord record,
  ) async {
    try {
      final now = DateTime.now();
      final created = record.copyWith(
        createdAt: record.createdAt ?? now,
        updatedAt: record.updatedAt ?? now,
      );

      // Write to local Drift immediately
      await _upsertToLocal(created, isSynced: false);

      // Push to Supabase
      try {
        await _client.from('maintenance_records').insert(
              _recordToSupabaseJson(created),
            );
        await _upsertToLocal(created, isSynced: true);
      } catch (_) {
        // Supabase push failed - local data is still saved with isSynced=false
        // It will be synced later when connectivity is restored
      }

      return right(created);
    } catch (e) {
      return left(ServerException(e.toString()));
    }
  }

  /// Updates an existing maintenance record: writes to Drift first,
  /// then pushes to Supabase.
  FutureEither<MaintenanceRecord> updateMaintenanceRecord(
    MaintenanceRecord record,
  ) async {
    try {
      final updated = record.copyWith(updatedAt: DateTime.now());

      // Write to local Drift immediately
      await _upsertToLocal(updated, isSynced: false);

      // Push to Supabase
      try {
        await _client
            .from('maintenance_records')
            .update(_recordToSupabaseJson(updated))
            .eq('id', updated.id);
        await _upsertToLocal(updated, isSynced: true);
      } catch (_) {
        // Supabase push failed - local data is still saved with isSynced=false
      }

      return right(updated);
    } catch (e) {
      return left(ServerException(e.toString()));
    }
  }

  /// Deletes a maintenance record from both Drift and Supabase.
  FutureVoid deleteMaintenanceRecord(String id) async {
    try {
      // Delete locally
      await (_db.delete(_db.maintenanceRecordsTable)
            ..where((t) => t.id.equals(id)))
          .go();

      // Delete from Supabase
      try {
        await _client.from('maintenance_records').delete().eq('id', id);
      } catch (_) {
        // Supabase delete failed - record already removed locally
      }

      return right(null);
    } catch (e) {
      return left(ServerException(e.toString()));
    }
  }

  /// Gets maintenance records with nextServiceDate in the future.
  /// Fetches from Supabase, caches to Drift, then returns.
  FutureEither<List<MaintenanceRecord>> getUpcomingMaintenance(
    String userId,
  ) async {
    try {
      final now = DateTime.now().toIso8601String();

      final response = await _client
          .from('maintenance_records')
          .select('*, vehicles!inner(user_id)')
          .eq('vehicles.user_id', userId)
          .gt('next_service_date', now)
          .order('next_service_date');

      final records = (response as List)
          .map((json) => MaintenanceRecord.fromJson(json as JsonMap))
          .toList();

      // Cache to local DB
      for (final record in records) {
        await _upsertToLocal(record);
      }

      return right(records);
    } on supabase.PostgrestException catch (e) {
      return left(ServerException(e.message));
    } catch (e) {
      return left(ServerException(e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  Future<void> _fetchAndCacheFromRemote(String vehicleId) async {
    try {
      final response = await _client
          .from('maintenance_records')
          .select()
          .eq('vehicle_id', vehicleId)
          .order('service_date', ascending: false);

      for (final json in response as List) {
        final record =
            MaintenanceRecord.fromJson(json as JsonMap);
        await _upsertToLocal(record);
      }
    } catch (_) {
      // Silently fail - local cache is still available
    }
  }

  Future<void> _upsertToLocal(
    MaintenanceRecord record, {
    bool isSynced = true,
  }) async {
    await _db.into(_db.maintenanceRecordsTable).insertOnConflictUpdate(
          MaintenanceRecordsTableCompanion(
            id: Value(record.id),
            vehicleId: Value(record.vehicleId),
            serviceType: Value(record.serviceType),
            title: Value(record.title),
            mileageAtService: Value(record.mileageAtService),
            cost: Value(record.cost),
            serviceDate: Value(record.serviceDate),
            garageId: Value(record.garageId),
            nextServiceDate: Value(record.nextServiceDate),
            nextServiceMileage: Value(record.nextServiceMileage),
            notes: Value(record.notes),
            photoUrls: Value(jsonEncode(record.photoUrls)),
            createdAt: Value(record.createdAt ?? DateTime.now()),
            updatedAt: Value(record.updatedAt ?? DateTime.now()),
            isSynced: Value(isSynced),
          ),
        );
  }

  MaintenanceRecord _mapRowToRecord(MaintenanceRecordsTableData row) {
    List<String> photoUrls;
    try {
      photoUrls = (jsonDecode(row.photoUrls) as List)
          .map((e) => e as String)
          .toList();
    } catch (_) {
      photoUrls = [];
    }

    return MaintenanceRecord(
      id: row.id,
      vehicleId: row.vehicleId,
      serviceType: row.serviceType,
      title: row.title,
      mileageAtService: row.mileageAtService,
      cost: row.cost,
      serviceDate: row.serviceDate,
      garageId: row.garageId,
      nextServiceDate: row.nextServiceDate,
      nextServiceMileage: row.nextServiceMileage,
      notes: row.notes,
      photoUrls: photoUrls,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  JsonMap _recordToSupabaseJson(MaintenanceRecord record) {
    return {
      'id': record.id,
      'vehicle_id': record.vehicleId,
      'service_type': record.serviceType,
      'title': record.title,
      'mileage_at_service': record.mileageAtService,
      'cost': record.cost,
      'service_date': record.serviceDate.toIso8601String(),
      'garage_id': record.garageId,
      'next_service_date': record.nextServiceDate?.toIso8601String(),
      'next_service_mileage': record.nextServiceMileage,
      'notes': record.notes,
      'photo_urls': record.photoUrls,
      'created_at': record.createdAt?.toIso8601String(),
      'updated_at': record.updatedAt?.toIso8601String(),
    };
  }
}

@Riverpod(keepAlive: true)
MaintenanceRepository maintenanceRepository(Ref ref) {
  return MaintenanceRepository(
    ref.watch(supabaseClientProvider),
    ref.watch(appDatabaseProvider),
  );
}
