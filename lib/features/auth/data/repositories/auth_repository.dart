import 'package:fpdart/fpdart.dart';
import 'package:mecano_app/core/errors/app_exception.dart';
import 'package:mecano_app/core/typedefs/typedefs.dart';
import 'package:mecano_app/features/auth/domain/models/app_user.dart';
import 'package:mecano_app/shared/providers/supabase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

part 'auth_repository.g.dart';

class AuthRepository {
  const AuthRepository(this._auth);

  final supabase.GoTrueClient _auth;

  FutureEither<AppUser> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;
      if (user == null) {
        return left(const AuthException('Sign in failed: no user returned'));
      }

      return right(
        AppUser(
          id: user.id,
          email: user.email ?? email,
          fullName: user.userMetadata?['full_name'] as String?,
          avatarUrl: user.userMetadata?['avatar_url'] as String?,
        ),
      );
    } on supabase.AuthException catch (e) {
      return left(AuthException(e.message));
    } catch (e) {
      return left(ServerException(e.toString()));
    }
  }

  FutureEither<AppUser> signUpWithEmail({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final response = await _auth.signUp(
        email: email,
        password: password,
        data: {'full_name': fullName},
      );

      final user = response.user;
      if (user == null) {
        return left(const AuthException('Sign up failed: no user returned'));
      }

      return right(
        AppUser(
          id: user.id,
          email: user.email ?? email,
          fullName: fullName,
          avatarUrl: user.userMetadata?['avatar_url'] as String?,
        ),
      );
    } on supabase.AuthException catch (e) {
      return left(AuthException(e.message));
    } catch (e) {
      return left(ServerException(e.toString()));
    }
  }

  FutureVoid signOut() async {
    try {
      await _auth.signOut();
      return right(null);
    } on supabase.AuthException catch (e) {
      return left(AuthException(e.message));
    } catch (e) {
      return left(ServerException(e.toString()));
    }
  }

  FutureVoid resetPassword(String email) async {
    try {
      await _auth.resetPasswordForEmail(email);
      return right(null);
    } on supabase.AuthException catch (e) {
      return left(AuthException(e.message));
    } catch (e) {
      return left(ServerException(e.toString()));
    }
  }

  AppUser? getCurrentUser() {
    final user = _auth.currentUser;
    if (user == null) return null;

    return AppUser(
      id: user.id,
      email: user.email ?? '',
      fullName: user.userMetadata?['full_name'] as String?,
      avatarUrl: user.userMetadata?['avatar_url'] as String?,
    );
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepository(ref.watch(supabaseAuthProvider));
}
