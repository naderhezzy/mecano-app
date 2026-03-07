import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mecano_app/core/errors/app_exception.dart';
import 'package:mecano_app/core/typedefs/typedefs.dart';
import 'package:mecano_app/database/app_database.dart';
import 'package:mecano_app/features/bookings/domain/models/booking.dart';
import 'package:mecano_app/shared/providers/database_provider.dart';
import 'package:mecano_app/shared/providers/supabase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

part 'booking_repository.g.dart';

class BookingRepository {
  const BookingRepository(this._client, this._db);

  final supabase.SupabaseClient _client;
  final AppDatabase _db;

  // ---------------------------------------------------------------------------
  // Watch bookings (offline-first via Drift stream)
  // ---------------------------------------------------------------------------

  /// Returns a reactive stream from Drift. Also triggers a background fetch
  /// from Supabase so the local cache stays up-to-date.
  Stream<List<Booking>> watchBookings(String userId) {
    // Fire-and-forget background refresh from Supabase
    _fetchAndCacheAllFromRemote(userId);

    final query = _db.select(_db.bookingsTable)
      ..where((t) => t.userId.equals(userId))
      ..orderBy([(t) => OrderingTerm.desc(t.appointmentDate)]);

    return query.watch().map(
          (rows) => rows.map(_mapRowToBooking).toList(),
        );
  }

  // ---------------------------------------------------------------------------
  // Get single booking
  // ---------------------------------------------------------------------------

  FutureEither<Booking> getBooking(String id) async {
    try {
      final row = await (_db.select(_db.bookingsTable)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();

      if (row != null) {
        // Also trigger a background refresh for this booking
        _fetchAndCacheSingleFromRemote(id);
        return right(_mapRowToBooking(row));
      }

      // Not in local cache - try Supabase
      final response = await _client
          .from('bookings')
          .select()
          .eq('id', id)
          .maybeSingle();

      if (response == null) {
        return left(const NotFoundException('Booking not found'));
      }

      final booking = _mapRemoteToBooking(response);
      await _upsertToLocal(booking);
      return right(booking);
    } on supabase.PostgrestException catch (e) {
      return left(ServerException(e.message));
    } catch (e) {
      return left(ServerException(e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Create booking
  // ---------------------------------------------------------------------------

  FutureEither<Booking> createBooking(Booking booking) async {
    try {
      // Write to Drift immediately with isSynced = false
      await _upsertToLocal(booking, isSynced: false);

      // Push to Supabase
      try {
        await _client
            .from('bookings')
            .insert(_bookingToRemoteMap(booking));

        // Mark as synced
        await _upsertToLocal(booking, isSynced: true);
      } catch (_) {
        // Supabase push failed - data is saved locally with isSynced=false
        // Will be synced when connectivity is restored
      }

      return right(booking);
    } catch (e) {
      return left(ServerException(e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Cancel booking
  // ---------------------------------------------------------------------------

  FutureEither<Booking> cancelBooking(String id) async {
    try {
      // Get current booking
      final row = await (_db.select(_db.bookingsTable)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();

      if (row == null) {
        return left(const NotFoundException('Booking not found'));
      }

      final now = DateTime.now();
      final cancelled = _mapRowToBooking(row).copyWith(
        status: 'cancelled',
        updatedAt: now,
      );

      // Write to Drift immediately
      await _upsertToLocal(cancelled, isSynced: false);

      // Push to Supabase
      try {
        await _client
            .from('bookings')
            .update({
              'status': 'cancelled',
              'updated_at': now.toIso8601String(),
            })
            .eq('id', id);

        await _upsertToLocal(cancelled, isSynced: true);
      } catch (_) {
        // Supabase push failed - local data is still saved
      }

      return right(cancelled);
    } catch (e) {
      return left(ServerException(e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Get upcoming bookings
  // ---------------------------------------------------------------------------

  FutureEither<List<Booking>> getUpcomingBookings(String userId) async {
    try {
      final now = DateTime.now().toIso8601String();

      final response = await _client
          .from('bookings')
          .select()
          .eq('user_id', userId)
          .gte('appointment_date', now)
          .inFilter('status', ['pending', 'confirmed'])
          .order('appointment_date');

      final bookings = (response as List)
          .map((json) => _mapRemoteToBooking(json as JsonMap))
          .toList();

      // Cache to local DB
      for (final booking in bookings) {
        await _upsertToLocal(booking);
      }

      return right(bookings);
    } on supabase.PostgrestException catch (e) {
      return left(ServerException(e.message));
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
          .from('bookings')
          .select()
          .eq('user_id', userId)
          .order('appointment_date', ascending: false);

      for (final json in response) {
        final booking = _mapRemoteToBooking(json);
        await _upsertToLocal(booking);
      }
    } catch (_) {
      // Silently fail - local cache is still available
    }
  }

  Future<void> _fetchAndCacheSingleFromRemote(String id) async {
    try {
      final response = await _client
          .from('bookings')
          .select()
          .eq('id', id)
          .maybeSingle();

      if (response != null) {
        final booking = _mapRemoteToBooking(response);
        await _upsertToLocal(booking);
      }
    } catch (_) {
      // Silently fail - local cache is still available
    }
  }

  Future<void> _upsertToLocal(
    Booking booking, {
    bool isSynced = true,
  }) async {
    await _db.into(_db.bookingsTable).insertOnConflictUpdate(
          BookingsTableCompanion(
            id: Value(booking.id),
            userId: Value(booking.userId),
            garageId: Value(booking.garageId),
            vehicleId: Value(booking.vehicleId),
            serviceCategoryId: Value(booking.serviceCategoryId),
            status: Value(booking.status),
            appointmentDate: Value(booking.appointmentDate),
            appointmentTime: Value(booking.appointmentTime),
            notes: Value(booking.notes),
            estimatedCost: Value(booking.estimatedCost),
            createdAt: Value(booking.createdAt),
            updatedAt: Value(booking.updatedAt),
            isSynced: Value(isSynced),
          ),
        );
  }

  Booking _mapRowToBooking(BookingsTableData row) {
    return Booking(
      id: row.id,
      userId: row.userId,
      garageId: row.garageId,
      vehicleId: row.vehicleId,
      serviceCategoryId: row.serviceCategoryId,
      status: row.status,
      appointmentDate: row.appointmentDate,
      appointmentTime: row.appointmentTime,
      notes: row.notes,
      estimatedCost: row.estimatedCost,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  Booking _mapRemoteToBooking(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      garageId: json['garage_id'] as String,
      vehicleId: json['vehicle_id'] as String,
      serviceCategoryId: json['service_category_id'] as String?,
      status: json['status'] as String? ?? 'pending',
      appointmentDate: DateTime.parse(json['appointment_date'] as String),
      appointmentTime: json['appointment_time'] as String,
      notes: json['notes'] as String?,
      estimatedCost: (json['estimated_cost'] as num?)?.toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> _bookingToRemoteMap(Booking booking) {
    return {
      'id': booking.id,
      'user_id': booking.userId,
      'garage_id': booking.garageId,
      'vehicle_id': booking.vehicleId,
      'service_category_id': booking.serviceCategoryId,
      'status': booking.status,
      'appointment_date': booking.appointmentDate.toIso8601String(),
      'appointment_time': booking.appointmentTime,
      'notes': booking.notes,
      'estimated_cost': booking.estimatedCost,
      'created_at': booking.createdAt.toIso8601String(),
      'updated_at': booking.updatedAt.toIso8601String(),
    };
  }
}

@Riverpod(keepAlive: true)
BookingRepository bookingRepository(Ref ref) {
  return BookingRepository(
    ref.watch(supabaseClientProvider),
    ref.watch(appDatabaseProvider),
  );
}
