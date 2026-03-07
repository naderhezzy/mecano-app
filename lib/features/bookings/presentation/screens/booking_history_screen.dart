import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mecano_app/core/extensions/context_extensions.dart';
import 'package:mecano_app/features/bookings/domain/models/booking.dart';
import 'package:mecano_app/features/bookings/domain/models/booking_status.dart';
import 'package:mecano_app/features/bookings/presentation/providers/booking_providers.dart';
import 'package:mecano_app/shared/providers/supabase_provider.dart';
import 'package:mecano_app/shared/widgets/app_error.dart';
import 'package:mecano_app/shared/widgets/app_loading.dart';
import 'package:mecano_app/shared/widgets/empty_state.dart';
import 'package:mecano_app/theme/app_colors.dart';
import 'package:mecano_app/theme/app_spacing.dart';

class BookingHistoryScreen extends ConsumerWidget {
  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(supabaseClientProvider).auth.currentUser?.id;

    if (userId == null) {
      return const Scaffold(
        body: AppError(message: 'Please log in to view bookings'),
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Bookings'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Upcoming'),
              Tab(text: 'Past'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _BookingListTab(userId: userId, showUpcoming: true),
            _BookingListTab(userId: userId, showUpcoming: false),
          ],
        ),
      ),
    );
  }
}

class _BookingListTab extends ConsumerWidget {
  const _BookingListTab({
    required this.userId,
    required this.showUpcoming,
  });

  final String userId;
  final bool showUpcoming;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingsAsync = ref.watch(bookingsProvider(userId));

    return bookingsAsync.when(
      loading: () => const AppLoading(message: 'Loading bookings...'),
      error: (error, _) => AppError(
        message: error.toString(),
        onRetry: () => ref.invalidate(bookingsProvider(userId)),
      ),
      data: (allBookings) {
        final now = DateTime.now();
        final filtered = allBookings.where((b) {
          final status = BookingStatus.fromString(b.status);
          if (showUpcoming) {
            return b.appointmentDate.isAfter(now) &&
                status != BookingStatus.cancelled &&
                status != BookingStatus.completed;
          } else {
            return b.appointmentDate.isBefore(now) ||
                status == BookingStatus.cancelled ||
                status == BookingStatus.completed;
          }
        }).toList();

        if (filtered.isEmpty) {
          return EmptyState(
            icon: showUpcoming
                ? Icons.calendar_today_outlined
                : Icons.history_outlined,
            title: showUpcoming ? 'No Upcoming Bookings' : 'No Past Bookings',
            description: showUpcoming
                ? 'Book an appointment with a garage to get started.'
                : 'Your completed and cancelled bookings will appear here.',
            actionLabel: showUpcoming ? 'Find a Garage' : null,
            onAction: showUpcoming ? () => context.go('/services') : null,
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(bookingsProvider(userId));
          },
          child: ListView.separated(
            padding: AppSpacing.paddingMd,
            itemCount: filtered.length,
            separatorBuilder: (_, __) => AppSpacing.verticalSm,
            itemBuilder: (context, index) {
              return _BookingCard(booking: filtered[index]);
            },
          ),
        );
      },
    );
  }
}

class _BookingCard extends StatelessWidget {
  const _BookingCard({required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final status = BookingStatus.fromString(booking.status);
    final dateFormat = DateFormat('EEE, MMM d, yyyy');

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push('/bookings/${booking.id}'),
        child: Padding(
          padding: AppSpacing.paddingMd,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row: garage id and status badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Booking',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  _StatusBadge(status: status),
                ],
              ),
              AppSpacing.verticalSm,

              // Date and time
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  AppSpacing.horizontalXs,
                  Text(
                    dateFormat.format(booking.appointmentDate),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  AppSpacing.horizontalMd,
                  const Icon(
                    Icons.access_time,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  AppSpacing.horizontalXs,
                  Text(
                    booking.appointmentTime,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),

              if (booking.notes != null && booking.notes!.isNotEmpty) ...[
                AppSpacing.verticalSm,
                Text(
                  booking.notes!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final BookingStatus status;

  Color get _color {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status.label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: _color,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
