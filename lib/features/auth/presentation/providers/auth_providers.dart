import 'package:mecano_app/features/auth/data/repositories/auth_repository.dart';
import 'package:mecano_app/features/auth/domain/models/app_user.dart';
import 'package:mecano_app/shared/providers/supabase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
class AuthState extends _$AuthState {
  @override
  Stream<AppUser?> build() async* {
    final authRepo = ref.watch(authRepositoryProvider);

    // Emit the current user immediately
    yield authRepo.getCurrentUser();

    // Then listen for auth state changes
    await for (final _ in ref.watch(supabaseAuthProvider).onAuthStateChange) {
      yield authRepo.getCurrentUser();
    }
  }
}
