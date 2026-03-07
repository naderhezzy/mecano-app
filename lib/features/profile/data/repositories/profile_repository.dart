import 'dart:io';

import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mecano_app/core/errors/app_exception.dart';
import 'package:mecano_app/core/typedefs/typedefs.dart';
import 'package:mecano_app/database/app_database.dart';
import 'package:mecano_app/features/profile/domain/models/user_profile.dart';
import 'package:mecano_app/shared/providers/database_provider.dart';
import 'package:mecano_app/shared/providers/supabase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

part 'profile_repository.g.dart';

class ProfileRepository {
  const ProfileRepository(this._client, this._db);

  final supabase.SupabaseClient _client;
  final AppDatabase _db;

  /// Reads from Drift first, then fetches from Supabase in background.
  FutureEither<UserProfile> getProfile(String userId) async {
    try {
      // Try reading from local Drift cache first
      final localRow = await (_db.select(_db.userProfilesTable)
            ..where((t) => t.id.equals(userId)))
          .getSingleOrNull();

      // Fire off a background Supabase fetch to keep cache fresh
      _fetchAndCacheFromRemote(userId);

      if (localRow != null) {
        return right(_mapRowToProfile(localRow));
      }

      // No local data – fetch from Supabase synchronously
      final response = await _client
          .from('user_profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (response == null) {
        // Return a default empty profile for the user
        final emptyProfile = UserProfile(id: userId);
        await _upsertToLocal(emptyProfile);
        return right(emptyProfile);
      }

      final profile = UserProfile.fromJson(response);
      await _upsertToLocal(profile);
      return right(profile);
    } on supabase.PostgrestException catch (e) {
      return left(ServerException(e.message));
    } catch (e) {
      return left(ServerException(e.toString()));
    }
  }

  /// Writes to Drift immediately, then pushes to Supabase.
  FutureEither<UserProfile> updateProfile(UserProfile profile) async {
    try {
      final now = DateTime.now();
      final updated = profile.copyWith(updatedAt: now);

      // Write to local Drift immediately
      await _upsertToLocal(updated, isSynced: false);

      // Push to Supabase
      try {
        await _client.from('user_profiles').upsert({
          'id': updated.id,
          'full_name': updated.fullName,
          'phone': updated.phone,
          'location': updated.location,
          'preferred_language': updated.preferredLanguage,
          'avatar_url': updated.avatarUrl,
          'updated_at': updated.updatedAt?.toIso8601String(),
        });

        // Mark as synced
        await _upsertToLocal(updated, isSynced: true);
      } catch (_) {
        // Supabase push failed – local data is still saved with isSynced=false
        // It will be synced later when connectivity is restored
      }

      return right(updated);
    } catch (e) {
      return left(ServerException(e.toString()));
    }
  }

  /// Uploads avatar image to Supabase storage 'avatars' bucket.
  FutureEither<String> uploadAvatar(String filePath) async {
    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) {
        return left(const AuthException('User not authenticated'));
      }

      final file = File(filePath);
      final fileExt = filePath.split('.').last.toLowerCase();
      final storagePath = '$userId/avatar.$fileExt';

      await _client.storage.from('avatars').upload(
            storagePath,
            file,
            fileOptions: const supabase.FileOptions(upsert: true),
          );

      final publicUrl =
          _client.storage.from('avatars').getPublicUrl(storagePath);

      return right(publicUrl);
    } on supabase.StorageException catch (e) {
      return left(ServerException(e.message));
    } catch (e) {
      return left(ServerException(e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  Future<void> _fetchAndCacheFromRemote(String userId) async {
    try {
      final response = await _client
          .from('user_profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (response != null) {
        final profile = UserProfile.fromJson(response);
        await _upsertToLocal(profile);
      }
    } catch (_) {
      // Silently fail – local cache is still available
    }
  }

  Future<void> _upsertToLocal(
    UserProfile profile, {
    bool isSynced = true,
  }) async {
    await _db.into(_db.userProfilesTable).insertOnConflictUpdate(
          UserProfilesTableCompanion(
            id: Value(profile.id),
            fullName: Value(profile.fullName),
            phone: Value(profile.phone),
            location: Value(profile.location),
            preferredLanguage: Value(profile.preferredLanguage),
            avatarUrl: Value(profile.avatarUrl),
            createdAt: Value(profile.createdAt ?? DateTime.now()),
            updatedAt: Value(profile.updatedAt ?? DateTime.now()),
            isSynced: Value(isSynced),
          ),
        );
  }

  UserProfile _mapRowToProfile(UserProfilesTableData row) {
    return UserProfile(
      id: row.id,
      fullName: row.fullName,
      phone: row.phone,
      location: row.location,
      preferredLanguage: row.preferredLanguage,
      avatarUrl: row.avatarUrl,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}

@Riverpod(keepAlive: true)
ProfileRepository profileRepository(Ref ref) {
  return ProfileRepository(
    ref.watch(supabaseClientProvider),
    ref.watch(appDatabaseProvider),
  );
}

@riverpod
Future<UserProfile> userProfile(Ref ref) async {
  final repo = ref.watch(profileRepositoryProvider);
  final userId = ref.watch(supabaseClientProvider).auth.currentUser?.id;

  if (userId == null) {
    throw const AuthException('User not authenticated');
  }

  final result = await repo.getProfile(userId);
  return result.fold(
    (error) => throw error,
    (profile) => profile,
  );
}
