import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mecano_app/core/errors/app_exception.dart';
import 'package:mecano_app/core/typedefs/typedefs.dart';
import 'package:mecano_app/database/app_database.dart';
import 'package:mecano_app/features/vehicles/domain/models/vehicle.dart';
import 'package:mecano_app/shared/providers/database_provider.dart';
import 'package:mecano_app/shared/providers/supabase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

part 'vehicle_repository.g.dart';

class VehicleRepository {
  const VehicleRepository(this._client, this._db);

  final supabase.SupabaseClient _client;
  final AppDatabase _db;

  // ---------------------------------------------------------------------------
  // Watch vehicles (offline-first via Drift stream)
  // ---------------------------------------------------------------------------

  /// Returns a reactive stream from Drift. Also triggers a background fetch
  /// from Supabase so the local cache stays up-to-date.
  Stream<List<Vehicle>> watchVehicles(String userId) {
    // Fire-and-forget background refresh from Supabase
    _fetchAndCacheAllFromRemote(userId);

    final query = _db.select(_db.vehiclesTable)
      ..where((t) => t.userId.equals(userId))
      ..orderBy([
        (t) => OrderingTerm.desc(t.isPrimary),
        (t) => OrderingTerm.desc(t.updatedAt),
      ]);

    return query.watch().map(
          (rows) => rows.map(_mapRowToVehicle).toList(),
        );
  }

  // ---------------------------------------------------------------------------
  // Get single vehicle
  // ---------------------------------------------------------------------------

  FutureEither<Vehicle> getVehicle(String id) async {
    try {
      final row = await (_db.select(_db.vehiclesTable)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();

      if (row != null) {
        return right(_mapRowToVehicle(row));
      }

      // Not in local cache – try Supabase
      final response = await _client
          .from('vehicles')
          .select()
          .eq('id', id)
          .maybeSingle();

      if (response == null) {
        return left(const NotFoundException('Vehicle not found'));
      }

      final vehicle = _mapRemoteToVehicle(response);
      await _upsertToLocal(vehicle);
      return right(vehicle);
    } on supabase.PostgrestException catch (e) {
      return left(ServerException(e.message));
    } catch (e) {
      return left(ServerException(e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Add vehicle
  // ---------------------------------------------------------------------------

  FutureEither<Vehicle> addVehicle(Vehicle vehicle) async {
    try {
      // Write to Drift immediately with isSynced = false
      await _upsertToLocal(vehicle, isSynced: false);

      // Push to Supabase
      try {
        await _client.from('vehicles').insert(_vehicleToRemoteMap(vehicle));

        // Mark as synced
        await _upsertToLocal(vehicle, isSynced: true);
      } catch (_) {
        // Supabase push failed – data is saved locally with isSynced=false
        // Will be synced when connectivity is restored
      }

      return right(vehicle);
    } catch (e) {
      return left(ServerException(e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Update vehicle
  // ---------------------------------------------------------------------------

  FutureEither<Vehicle> updateVehicle(Vehicle vehicle) async {
    try {
      final updated = vehicle.copyWith(updatedAt: DateTime.now());

      // Write to Drift immediately
      await _upsertToLocal(updated, isSynced: false);

      // Push to Supabase
      try {
        await _client
            .from('vehicles')
            .update(_vehicleToRemoteMap(updated))
            .eq('id', updated.id);

        // Mark as synced
        await _upsertToLocal(updated, isSynced: true);
      } catch (_) {
        // Supabase push failed – local data is still saved
      }

      return right(updated);
    } catch (e) {
      return left(ServerException(e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Delete vehicle
  // ---------------------------------------------------------------------------

  FutureVoid deleteVehicle(String id) async {
    try {
      // Delete from local Drift
      await (_db.delete(_db.vehiclesTable)
            ..where((t) => t.id.equals(id)))
          .go();

      // Delete from Supabase
      try {
        await _client.from('vehicles').delete().eq('id', id);
      } catch (_) {
        // Remote delete failed – already removed locally
      }

      return right(null);
    } catch (e) {
      return left(ServerException(e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Set primary vehicle
  // ---------------------------------------------------------------------------

  FutureVoid setPrimaryVehicle(String vehicleId, String userId) async {
    try {
      // Unset all primaries for this user in Drift
      await (_db.update(_db.vehiclesTable)
            ..where((t) => t.userId.equals(userId)))
          .write(
        const VehiclesTableCompanion(isPrimary: Value(false)),
      );

      // Set the selected vehicle as primary
      await (_db.update(_db.vehiclesTable)
            ..where((t) => t.id.equals(vehicleId)))
          .write(
        const VehiclesTableCompanion(
          isPrimary: Value(true),
          isSynced: Value(false),
        ),
      );

      // Push to Supabase
      try {
        await _client
            .from('vehicles')
            .update({'is_primary': false})
            .eq('user_id', userId);

        await _client
            .from('vehicles')
            .update({'is_primary': true})
            .eq('id', vehicleId);

        // Mark all as synced
        await (_db.update(_db.vehiclesTable)
              ..where((t) => t.userId.equals(userId)))
            .write(const VehiclesTableCompanion(isSynced: Value(true)));
      } catch (_) {
        // Remote push failed – local state is still correct
      }

      return right(null);
    } catch (e) {
      return left(ServerException(e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Sync all unsynced vehicles to Supabase
  // ---------------------------------------------------------------------------

  FutureVoid syncVehicles(String userId) async {
    try {
      final unsyncedRows = await (_db.select(_db.vehiclesTable)
            ..where(
              (t) =>
                  t.userId.equals(userId) &
                  t.isSynced.equals(false),
            ))
          .get();

      for (final row in unsyncedRows) {
        final vehicle = _mapRowToVehicle(row);
        try {
          await _client
              .from('vehicles')
              .upsert(_vehicleToRemoteMap(vehicle));

          await (_db.update(_db.vehiclesTable)
                ..where((t) => t.id.equals(vehicle.id)))
              .write(const VehiclesTableCompanion(isSynced: Value(true)));
        } catch (_) {
          // Skip this vehicle – will retry on next sync
        }
      }

      return right(null);
    } catch (e) {
      return left(ServerException(e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  Future<void> _fetchAndCacheAllFromRemote(String userId) async {
    try {
      final response = await _client
          .from('vehicles')
          .select()
          .eq('user_id', userId)
          .order('updated_at', ascending: false);

      for (final row in response) {
        final vehicle = _mapRemoteToVehicle(row);
        await _upsertToLocal(vehicle);
      }
    } catch (_) {
      // Silently fail – local cache is still available
    }
  }

  Future<void> _upsertToLocal(
    Vehicle vehicle, {
    bool isSynced = true,
  }) async {
    await _db.into(_db.vehiclesTable).insertOnConflictUpdate(
          VehiclesTableCompanion(
            id: Value(vehicle.id),
            userId: Value(vehicle.userId),
            make: Value(vehicle.make),
            model: Value(vehicle.model),
            year: Value(vehicle.year),
            mileage: Value(vehicle.mileage),
            vin: Value(vehicle.vin),
            fuelType: Value(vehicle.fuelType),
            plateNumber: Value(vehicle.plateNumber),
            color: Value(vehicle.color),
            photoUrls: Value(jsonEncode(vehicle.photoUrls)),
            notes: Value(vehicle.notes),
            isPrimary: Value(vehicle.isPrimary),
            createdAt: Value(vehicle.createdAt),
            updatedAt: Value(vehicle.updatedAt),
            isSynced: Value(isSynced),
          ),
        );
  }

  Vehicle _mapRowToVehicle(VehiclesTableData row) {
    List<String> photoUrls;
    try {
      photoUrls = (jsonDecode(row.photoUrls) as List)
          .map((e) => e as String)
          .toList();
    } catch (_) {
      photoUrls = [];
    }

    return Vehicle(
      id: row.id,
      userId: row.userId,
      make: row.make,
      model: row.model,
      year: row.year,
      mileage: row.mileage,
      vin: row.vin,
      fuelType: row.fuelType,
      plateNumber: row.plateNumber,
      color: row.color,
      photoUrls: photoUrls,
      notes: row.notes,
      isPrimary: row.isPrimary,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  Vehicle _mapRemoteToVehicle(Map<String, dynamic> json) {
    List<String> photoUrls;
    final raw = json['photo_urls'];
    if (raw is List) {
      photoUrls = raw.map((e) => e.toString()).toList();
    } else if (raw is String) {
      try {
        photoUrls =
            (jsonDecode(raw) as List).map((e) => e as String).toList();
      } catch (_) {
        photoUrls = [];
      }
    } else {
      photoUrls = [];
    }

    return Vehicle(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      make: json['make'] as String,
      model: json['model'] as String,
      year: json['year'] as int,
      mileage: json['mileage'] as int,
      vin: json['vin'] as String?,
      fuelType: json['fuel_type'] as String,
      plateNumber: json['plate_number'] as String?,
      color: json['color'] as String?,
      photoUrls: photoUrls,
      notes: json['notes'] as String?,
      isPrimary: json['is_primary'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> _vehicleToRemoteMap(Vehicle vehicle) {
    return {
      'id': vehicle.id,
      'user_id': vehicle.userId,
      'make': vehicle.make,
      'model': vehicle.model,
      'year': vehicle.year,
      'mileage': vehicle.mileage,
      'vin': vehicle.vin,
      'fuel_type': vehicle.fuelType,
      'plate_number': vehicle.plateNumber,
      'color': vehicle.color,
      'photo_urls': vehicle.photoUrls,
      'notes': vehicle.notes,
      'is_primary': vehicle.isPrimary,
      'created_at': vehicle.createdAt.toIso8601String(),
      'updated_at': vehicle.updatedAt.toIso8601String(),
    };
  }
}

@Riverpod(keepAlive: true)
VehicleRepository vehicleRepository(Ref ref) {
  return VehicleRepository(
    ref.watch(supabaseClientProvider),
    ref.watch(appDatabaseProvider),
  );
}
