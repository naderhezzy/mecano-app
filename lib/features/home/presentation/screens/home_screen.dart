import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mecano_app/core/extensions/context_extensions.dart';
import 'package:mecano_app/features/auth/presentation/providers/auth_providers.dart';
import 'package:mecano_app/features/bookings/domain/models/booking_status.dart';
import 'package:mecano_app/features/bookings/presentation/providers/booking_providers.dart';
import 'package:mecano_app/features/maintenance/presentation/providers/maintenance_providers.dart';
import 'package:mecano_app/features/vehicles/presentation/providers/vehicle_providers.dart';
import 'package:mecano_app/shared/providers/supabase_provider.dart';
import 'package:mecano_app/theme/app_colors.dart';
import 'package:mecano_app/theme/app_spacing.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final userId =
        ref.watch(supabaseClientProvider).auth.currentUser?.id ?? '';
    final userName = authState.valueOrNull?.fullName;

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref
              ..invalidate(primaryVehicleProvider(userId))
              ..invalidate(upcomingMaintenanceProvider(userId))
              ..invalidate(upcomingBookingsProvider(userId));
          },
          child: ListView(
            padding: AppSpacing.paddingMd,
            children: [
              // Greeting header
              _GreetingHeader(
                name: userName,
                avatarUrl: authState.valueOrNull?.avatarUrl,
              ),
              AppSpacing.verticalLg,

              // Primary vehicle card
              _PrimaryVehicleSection(userId: userId),
              AppSpacing.verticalLg,

              // Upcoming maintenance
              _UpcomingMaintenanceSection(userId: userId),
              AppSpacing.verticalLg,

              // Recent bookings
              _RecentBookingsSection(userId: userId),
              AppSpacing.verticalLg,

              // Quick actions
              const _QuickActionsSection(),
              AppSpacing.verticalLg,
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Greeting header
// ---------------------------------------------------------------------------

class _GreetingHeader extends StatelessWidget {
  const _GreetingHeader({this.name, this.avatarUrl});

  final String? name;
  final String? avatarUrl;

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$_greeting,',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              Text(
                name ?? 'User',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => context.go('/profile'),
          child: CircleAvatar(
            radius: 24,
            backgroundImage:
                avatarUrl != null ? NetworkImage(avatarUrl!) : null,
            child: avatarUrl == null
                ? const Icon(Icons.person, size: 28)
                : null,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Primary vehicle section
// ---------------------------------------------------------------------------

class _PrimaryVehicleSection extends ConsumerWidget {
  const _PrimaryVehicleSection({required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primaryAsync = ref.watch(primaryVehicleProvider(userId));

    return primaryAsync.when(
      loading: () => const Card(
        child: SizedBox(
          height: 100,
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (_, __) => const SizedBox.shrink(),
      data: (vehicle) {
        if (vehicle == null) {
          // No vehicle
          return Card(
            child: Padding(
              padding: AppSpacing.paddingMd,
              child: Column(
                children: [
                  const Icon(
                    Icons.directions_car_outlined,
                    size: 48,
                    color: AppColors.textSecondary,
                  ),
                  AppSpacing.verticalSm,
                  Text(
                    'No vehicles yet',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  AppSpacing.verticalXs,
                  Text(
                    'Add your first vehicle to get started',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  AppSpacing.verticalMd,
                  FilledButton.icon(
                    onPressed: () => context.push('/garage/add'),
                    icon: const Icon(Icons.add),
                    label: const Text('Add Vehicle'),
                  ),
                ],
              ),
            ),
          );
        }

        return Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => context.push('/garage/${vehicle.id}'),
            child: Padding(
              padding: AppSpacing.paddingMd,
              child: Row(
                children: [
                  // Vehicle photo or icon
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: vehicle.photoUrls.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              vehicle.photoUrls.first,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Icon(
                                Icons.directions_car,
                                color: AppColors.primary,
                                size: 32,
                              ),
                            ),
                          )
                        : const Icon(
                            Icons.directions_car,
                            color: AppColors.primary,
                            size: 32,
                          ),
                  ),
                  AppSpacing.horizontalMd,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${vehicle.make} ${vehicle.model}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            AppSpacing.horizontalSm,
                            if (vehicle.isPrimary)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary
                                      .withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'Primary',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                          ],
                        ),
                        AppSpacing.verticalXs,
                        Text(
                          '${vehicle.year} - ${NumberFormat.decimalPattern().format(vehicle.mileage)} km',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Upcoming maintenance section
// ---------------------------------------------------------------------------

class _UpcomingMaintenanceSection extends ConsumerWidget {
  const _UpcomingMaintenanceSection({required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maintenanceAsync = ref.watch(upcomingMaintenanceProvider(userId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upcoming Maintenance',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        AppSpacing.verticalSm,
        maintenanceAsync.when(
          loading: () => const SizedBox(
            height: 60,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (_, __) => Text(
            'Could not load maintenance',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          data: (records) {
            if (records.isEmpty) {
              return Card(
                child: Padding(
                  padding: AppSpacing.paddingMd,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: AppColors.success,
                      ),
                      AppSpacing.horizontalSm,
                      Expanded(
                        child: Text(
                          'No upcoming maintenance scheduled',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Column(
              children: records.take(3).map((record) {
                final dateFormat = DateFormat('MMM d, yyyy');
                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: AppColors.warning,
                      child: Icon(Icons.build, color: Colors.white, size: 20),
                    ),
                    title: Text(
                      record.title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    subtitle: record.nextServiceDate != null
                        ? Text(
                            'Due: ${dateFormat.format(record.nextServiceDate!)}',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                          )
                        : null,
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: AppColors.textSecondary,
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Recent bookings section
// ---------------------------------------------------------------------------

class _RecentBookingsSection extends ConsumerWidget {
  const _RecentBookingsSection({required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingsAsync = ref.watch(upcomingBookingsProvider(userId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Bookings',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextButton(
              onPressed: () => context.go('/bookings'),
              child: const Text('View All'),
            ),
          ],
        ),
        bookingsAsync.when(
          loading: () => const SizedBox(
            height: 60,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (_, __) => Text(
            'Could not load bookings',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          data: (bookings) {
            if (bookings.isEmpty) {
              return Card(
                child: Padding(
                  padding: AppSpacing.paddingMd,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        color: AppColors.textSecondary,
                      ),
                      AppSpacing.horizontalSm,
                      Expanded(
                        child: Text(
                          'No upcoming bookings',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            final dateFormat = DateFormat('EEE, MMM d');

            return Column(
              children: bookings.take(3).map((booking) {
                final status = BookingStatus.fromString(booking.status);
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () => context.push('/bookings/${booking.id}'),
                    child: Padding(
                      padding: AppSpacing.paddingMd,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dateFormat
                                      .format(booking.appointmentDate),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                AppSpacing.verticalXs,
                                Text(
                                  booking.appointmentTime,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: AppSpacing.xs,
                            ),
                            decoration: BoxDecoration(
                              color: _statusColor(status)
                                  .withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              status.label,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: _statusColor(status),
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  Color _statusColor(BookingStatus status) {
    switch (status) {
      case BookingStatus.pending:
        return AppColors.warning;
      case BookingStatus.confirmed:
        return AppColors.info;
      case BookingStatus.inProgress:
        return AppColors.primary;
      case BookingStatus.completed:
        return AppColors.success;
      case BookingStatus.cancelled:
        return AppColors.error;
    }
  }
}

// ---------------------------------------------------------------------------
// Quick actions section
// ---------------------------------------------------------------------------

class _QuickActionsSection extends StatelessWidget {
  const _QuickActionsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        AppSpacing.verticalSm,
        GridView.count(
          crossAxisCount: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: AppSpacing.sm,
          crossAxisSpacing: AppSpacing.sm,
          children: [
            _QuickActionButton(
              icon: Icons.directions_car,
              label: 'Add Vehicle',
              onTap: () => context.push('/garage/add'),
            ),
            _QuickActionButton(
              icon: Icons.build,
              label: 'Log Service',
              onTap: () => context.go('/garage'),
            ),
            _QuickActionButton(
              icon: Icons.location_on,
              label: 'Find Garage',
              onTap: () => context.go('/services'),
            ),
            _QuickActionButton(
              icon: Icons.calendar_today,
              label: 'Bookings',
              onTap: () => context.go('/bookings'),
            ),
          ],
        ),
      ],
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.primary, size: 28),
            AppSpacing.verticalXs,
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
