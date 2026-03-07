import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mecano_app/core/errors/app_exception.dart';
import 'package:mecano_app/core/typedefs/typedefs.dart';
import 'package:mecano_app/database/app_database.dart';
import 'package:mecano_app/features/garages/domain/models/garage.dart';
import 'package:mecano_app/features/garages/domain/models/garage_review.dart';
import 'package:mecano_app/features/garages/domain/models/garage_service.dart';
import 'package:mecano_app/shared/providers/database_provider.dart';
import 'package:mecano_app/shared/providers/supabase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

part 'garage_repository.g.dart';

class GarageRepository {
  const GarageRepository(this._client, this._db);

  final supabase.SupabaseClient _client;
  final AppDatabase _db;

  /// Fetches garages from Supabase with optional city/search filters.
  /// Results are cached locally in Drift.
  FutureEither<List<Garage>> getGarages({
    String? city,
    String? searchQuery,
  }) async {
    try {
      // Try remote first
      var query = _client.from('garages').select();

      if (city != null && city.isNotEmpty) {
        query = query.eq('city', city);
      }

      if (searchQuery != null && searchQuery.isNotEmpty) {
        query = query.or('name.ilike.%$searchQuery%,address.ilike.%$searchQuery%');
      }

      final response = await query.order('average_rating', ascending: false);

      final garages = (response as List<dynamic>)
          .map((json) => Garage.fromJson(json as Map<String, dynamic>))
          .toList();

      // Cache all fetched garages locally
      for (final garage in garages) {
        await _upsertGarageToLocal(garage);
      }

      return right(garages);
    } on supabase.PostgrestException catch (e) {
      // On remote failure, fall back to local cache
      return _getGaragesFromLocal(city: city, searchQuery: searchQuery);
    } catch (e) {
      // On any failure, try local cache
      return _getGaragesFromLocal(city: city, searchQuery: searchQuery);
    }
  }

  /// Fetches a single garage by id.
  FutureEither<Garage> getGarage(String id) async {
    try {
      final response = await _client
          .from('garages')
          .select()
          .eq('id', id)
          .maybeSingle();

      if (response == null) {
        // Try local cache
        final localRow = await (_db.select(_db.garagesTable)
              ..where((t) => t.id.equals(id)))
            .getSingleOrNull();

        if (localRow == null) {
          return left(const NotFoundException('Garage not found'));
        }

        return right(_mapRowToGarage(localRow));
      }

      final garage = Garage.fromJson(response);
      await _upsertGarageToLocal(garage);
      return right(garage);
    } on supabase.PostgrestException catch (e) {
      return left(ServerException(e.message));
    } catch (e) {
      // Try local cache on failure
      try {
        final localRow = await (_db.select(_db.garagesTable)
              ..where((t) => t.id.equals(id)))
            .getSingleOrNull();

        if (localRow != null) {
          return right(_mapRowToGarage(localRow));
        }
      } catch (_) {
        // Ignore local cache errors
      }
      return left(ServerException(e.toString()));
    }
  }

  /// Fetches services offered by a garage.
  FutureEither<List<GarageService>> getGarageServices(String garageId) async {
    try {
      final response = await _client
          .from('garage_services')
          .select()
          .eq('garage_id', garageId);

      final services = (response as List<dynamic>)
          .map((json) => GarageService.fromJson(json as Map<String, dynamic>))
          .toList();

      return right(services);
    } on supabase.PostgrestException catch (e) {
      return left(ServerException(e.message));
    } catch (e) {
      return left(ServerException(e.toString()));
    }
  }

  /// Fetches reviews for a garage.
  FutureEither<List<GarageReview>> getGarageReviews(String garageId) async {
    try {
      final response = await _client
          .from('garage_reviews')
          .select()
          .eq('garage_id', garageId)
          .order('created_at', ascending: false);

      final reviews = (response as List<dynamic>)
          .map((json) => GarageReview.fromJson(json as Map<String, dynamic>))
          .toList();

      return right(reviews);
    } on supabase.PostgrestException catch (e) {
      return left(ServerException(e.message));
    } catch (e) {
      return left(ServerException(e.toString()));
    }
  }

  /// Adds a review for a garage.
  FutureEither<GarageReview> addReview(GarageReview review) async {
    try {
      final response = await _client.from('garage_reviews').insert({
        'id': review.id,
        'garage_id': review.garageId,
        'user_id': review.userId,
        'rating': review.rating,
        'comment': review.comment,
        'created_at': review.createdAt?.toIso8601String(),
        'updated_at': review.updatedAt?.toIso8601String(),
      }).select().single();

      return right(GarageReview.fromJson(response));
    } on supabase.PostgrestException catch (e) {
      return left(ServerException(e.message));
    } catch (e) {
      return left(ServerException(e.toString()));
    }
  }

  /// Returns distinct cities from the garages table.
  FutureEither<List<String>> getCities() async {
    try {
      final response = await _client
          .from('garages')
          .select('city')
          .order('city');

      final cities = (response as List<dynamic>)
          .map((json) => (json as Map<String, dynamic>)['city'] as String)
          .toSet()
          .toList();

      return right(cities);
    } on supabase.PostgrestException catch (e) {
      return left(ServerException(e.message));
    } catch (e) {
      return left(ServerException(e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  Future<void> _upsertGarageToLocal(Garage garage) async {
    await _db.into(_db.garagesTable).insertOnConflictUpdate(
          GaragesTableCompanion(
            id: Value(garage.id),
            name: Value(garage.name),
            address: Value(garage.address),
            city: Value(garage.city),
            lat: Value(garage.lat),
            lng: Value(garage.lng),
            phone: Value(garage.phone),
            photoUrls: Value(jsonEncode(garage.photoUrls)),
            averageRating: Value(garage.averageRating),
            totalReviews: Value(garage.totalReviews),
            isVerified: Value(garage.isVerified),
            workingHours: Value(jsonEncode(garage.workingHours)),
            createdAt: Value(garage.createdAt ?? DateTime.now()),
            updatedAt: Value(garage.updatedAt ?? DateTime.now()),
          ),
        );
  }

  FutureEither<List<Garage>> _getGaragesFromLocal({
    String? city,
    String? searchQuery,
  }) async {
    try {
      var query = _db.select(_db.garagesTable);

      if (city != null && city.isNotEmpty) {
        query = query..where((t) => t.city.equals(city));
      }

      if (searchQuery != null && searchQuery.isNotEmpty) {
        query = query
          ..where(
            (t) =>
                t.name.like('%$searchQuery%') |
                t.address.like('%$searchQuery%'),
          );
      }

      final rows = await query.get();
      final garages = rows.map(_mapRowToGarage).toList();
      return right(garages);
    } catch (e) {
      return left(CacheException(e.toString()));
    }
  }

  Garage _mapRowToGarage(GaragesTableData row) {
    List<String> photoUrls;
    try {
      photoUrls = (jsonDecode(row.photoUrls) as List<dynamic>)
          .map((e) => e as String)
          .toList();
    } catch (_) {
      photoUrls = [];
    }

    Map<String, dynamic> workingHours;
    try {
      workingHours =
          jsonDecode(row.workingHours) as Map<String, dynamic>;
    } catch (_) {
      workingHours = {};
    }

    return Garage(
      id: row.id,
      name: row.name,
      address: row.address,
      city: row.city,
      lat: row.lat,
      lng: row.lng,
      phone: row.phone,
      photoUrls: photoUrls,
      averageRating: row.averageRating,
      totalReviews: row.totalReviews,
      isVerified: row.isVerified,
      workingHours: workingHours,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}

@Riverpod(keepAlive: true)
GarageRepository garageRepository(Ref ref) {
  return GarageRepository(
    ref.watch(supabaseClientProvider),
    ref.watch(appDatabaseProvider),
  );
}
