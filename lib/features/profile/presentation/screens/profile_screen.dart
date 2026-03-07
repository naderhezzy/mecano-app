import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mecano_app/core/constants/app_constants.dart';
import 'package:mecano_app/core/extensions/context_extensions.dart';
import 'package:mecano_app/features/auth/data/repositories/auth_repository.dart';
import 'package:mecano_app/features/profile/data/repositories/profile_repository.dart';
import 'package:mecano_app/shared/providers/supabase_provider.dart';
import 'package:mecano_app/theme/app_spacing.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(userProfileProvider);
    final currentUser =
        ref.watch(supabaseClientProvider.select((c) => c.auth.currentUser));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          TextButton.icon(
            onPressed: () => context.push('/profile/edit'),
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Edit'),
          ),
        ],
      ),
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Failed to load profile',
                style: context.textTheme.bodyLarge,
              ),
              AppSpacing.verticalSm,
              Text(
                error.toString(),
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.error,
                ),
                textAlign: TextAlign.center,
              ),
              AppSpacing.verticalMd,
              OutlinedButton(
                onPressed: () => ref.invalidate(userProfileProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (profile) => ListView(
          padding: AppSpacing.paddingMd,
          children: [
            // Avatar & Name header
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor:
                        context.colorScheme.primaryContainer,
                    backgroundImage: profile.avatarUrl != null
                        ? CachedNetworkImageProvider(profile.avatarUrl!)
                        : null,
                    child: profile.avatarUrl == null
                        ? Icon(
                            Icons.person,
                            size: 48,
                            color: context.colorScheme.onPrimaryContainer,
                          )
                        : null,
                  ),
                  AppSpacing.verticalMd,
                  Text(
                    profile.fullName ?? 'No name set',
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (currentUser?.email != null) ...[
                    AppSpacing.verticalXs,
                    Text(
                      currentUser!.email!,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            AppSpacing.verticalXl,

            // Personal info section
            _SectionHeader(title: 'Personal Information'),
            Card(
              child: Column(
                children: [
                  _InfoTile(
                    icon: Icons.phone_outlined,
                    title: 'Phone',
                    value: profile.phone ?? 'Not set',
                  ),
                  const Divider(),
                  _InfoTile(
                    icon: Icons.location_on_outlined,
                    title: 'Location',
                    value: profile.location ?? 'Not set',
                  ),
                ],
              ),
            ),
            AppSpacing.verticalLg,

            // Settings section
            _SectionHeader(title: 'Settings'),
            Card(
              child: Column(
                children: [
                  _InfoTile(
                    icon: Icons.language_outlined,
                    title: 'Preferred Language',
                    value: _languageLabel(profile.preferredLanguage),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('About App'),
                    subtitle: Text(
                      '${AppConstants.appName} v1.0.0',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    trailing:
                        const Icon(Icons.chevron_right, size: 20),
                  ),
                ],
              ),
            ),
            AppSpacing.verticalXl,

            // Logout button
            OutlinedButton.icon(
              onPressed: () => _handleLogout(context, ref),
              style: OutlinedButton.styleFrom(
                foregroundColor: context.colorScheme.error,
                side: BorderSide(color: context.colorScheme.error),
              ),
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
            ),
            AppSpacing.verticalLg,
          ],
        ),
      ),
    );
  }

  String _languageLabel(String code) {
    switch (code) {
      case 'fr':
        return 'Fran\u00e7ais';
      case 'en':
      default:
        return 'English';
    }
  }

  Future<void> _handleLogout(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(ctx).colorScheme.error,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    final result = await ref.read(authRepositoryProvider).signOut();

    if (!context.mounted) return;

    result.fold(
      (error) => context.showSnackBar(error.message, isError: true),
      (_) => context.go('/auth/login'),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSpacing.xs,
        bottom: AppSpacing.sm,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(
        value,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
      ),
    );
  }
}
