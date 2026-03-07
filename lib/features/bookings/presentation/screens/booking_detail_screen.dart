import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mecano_app/core/extensions/context_extensions.dart';
import 'package:mecano_app/core/utils/currency_formatter.dart';
import 'package:mecano_app/features/bookings/data/repositories/booking_repository.dart';
import 'package:mecano_app/features/bookings/domain/models/booking_status.dart';
import 'package:mecano_app/features/bookings/presentation/providers/booking_providers.dart';
import 'package:mecano_app/features/vehicles/presentation/providers/vehicle_providers.dart';
import 'package:mecano_app/shared/widgets/app_error.dart';
import 'package:mecano_app/shared/widgets/app_loading.dart';
import 'package:mecano_app/theme/app_colors.dart';
import 'package:mecano_app/theme/app_spacing.dart';

class BookingDetailScreen extends ConsumerWidget {
  const BookingDetailScreen({required this.bookingId, super.key});

  final String bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingAsync = ref.watch(bookingDetailProvider(bookingId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
      ),
      body: bookingAsync.when(
        loading: () => const AppLoading(message: 'Loading booking...'),
        error: (error, _) => AppError(
          message: error.toString(),
          onRetry: () => ref.invalidate(bookingDetailProvider(bookingId)),
        ),
        data: (booking) {
          final status = BookingStatus.fromString(booking.status);
          final dateFormat = DateFormat('EEEE, MMMM d, yyyy');
          final canCancel = status == BookingStatus.pending ||
              status == BookingStatus.confirmed;

          return SingleChildScrollView(
            padding: AppSpacing.paddingMd,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status timeline
                _StatusTimeline(currentStatus: status),
                AppSpacing.verticalLg,

                // Booking info card
                Card(
                  child: Padding(
                    padding: AppSpacing.paddingMd,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Appointment Details',
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(),
                        AppSpacing.verticalSm,

                        // Date
                        _InfoRow(
                          icon: Icons.calendar_today,
                          label: 'Date',
                          value: dateFormat.format(booking.appointmentDate),
                        ),
                        AppSpacing.verticalSm,

                        // Time
                        _InfoRow(
                          icon: Icons.access_time,
                          label: 'Time',
                          value: booking.appointmentTime,
                        ),
                        AppSpacing.verticalSm,

                        // Status
                        _InfoRow(
                          icon: Icons.info_outline,
                          label: 'Status',
                          value: status.label,
                          valueColor: _statusColor(status),
                        ),

                        // Estimated cost
                        if (booking.estimatedCost != null) ...[
                          AppSpacing.verticalSm,
                          _InfoRow(
                            icon: Icons.attach_money,
                            label: 'Estimated Cost',
                            value: CurrencyFormatter.formatTND(
                                booking.estimatedCost!),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                AppSpacing.verticalMd,

                // Vehicle info card
                _VehicleInfoCard(vehicleId: booking.vehicleId),
                AppSpacing.verticalMd,

                // Notes card
                if (booking.notes != null && booking.notes!.isNotEmpty) ...[
                  Card(
                    child: Padding(
                      padding: AppSpacing.paddingMd,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Notes',
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(),
                          AppSpacing.verticalSm,
                          Text(
                            booking.notes!,
                            style: context.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppSpacing.verticalMd,
                ],

                // Created at
                Card(
                  child: Padding(
                    padding: AppSpacing.paddingMd,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Booking Info',
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(),
                        AppSpacing.verticalSm,
                        _InfoRow(
                          icon: Icons.create,
                          label: 'Created',
                          value: DateFormat('MMM d, yyyy - HH:mm')
                              .format(booking.createdAt),
                        ),
                        AppSpacing.verticalSm,
                        _InfoRow(
                          icon: Icons.update,
                          label: 'Updated',
                          value: DateFormat('MMM d, yyyy - HH:mm')
                              .format(booking.updatedAt),
                        ),
                      ],
                    ),
                  ),
                ),
                AppSpacing.verticalLg,

                // Cancel button
                if (canCancel) ...[
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => _showCancelDialog(context, ref),
                      icon: const Icon(Icons.cancel_outlined),
                      label: const Text('Cancel Booking'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error,
                        side: const BorderSide(color: AppColors.error),
                      ),
                    ),
                  ),
                  AppSpacing.verticalLg,
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  void _showCancelDialog(BuildContext context, WidgetRef ref) {
    showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Cancel Booking'),
        content: const Text(
          'Are you sure you want to cancel this booking? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Keep Booking'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Cancel Booking'),
          ),
        ],
      ),
    ).then((confirmed) async {
      if (confirmed == true) {
        final repo = ref.read(bookingRepositoryProvider);
        final result = await repo.cancelBooking(bookingId);

        if (!context.mounted) return;

        result.fold(
          (error) => context.showSnackBar(error.message, isError: true),
          (_) {
            context.showSnackBar('Booking cancelled');
            ref.invalidate(bookingDetailProvider(bookingId));
          },
        );
      }
    });
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
// Status timeline widget
// ---------------------------------------------------------------------------

class _StatusTimeline extends StatelessWidget {
  const _StatusTimeline({required this.currentStatus});

  final BookingStatus currentStatus;

  @override
  Widget build(BuildContext context) {
    final steps = [
      BookingStatus.pending,
      BookingStatus.confirmed,
      BookingStatus.inProgress,
      BookingStatus.completed,
    ];

    if (currentStatus == BookingStatus.cancelled) {
      return Card(
        color: AppColors.error.withValues(alpha: 0.1),
        child: Padding(
          padding: AppSpacing.paddingMd,
          child: Row(
            children: [
              const Icon(Icons.cancel, color: AppColors.error),
              AppSpacing.horizontalSm,
              Text(
                'This booking has been cancelled',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.error,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      );
    }

    final currentIndex = steps.indexOf(currentStatus);

    return Card(
      child: Padding(
        padding: AppSpacing.paddingMd,
        child: Row(
          children: List.generate(steps.length * 2 - 1, (index) {
            if (index.isOdd) {
              // Connector line
              final stepIndex = index ~/ 2;
              final isCompleted = stepIndex < currentIndex;
              return Expanded(
                child: Container(
                  height: 3,
                  color: isCompleted
                      ? AppColors.success
                      : AppColors.divider,
                ),
              );
            }

            // Step circle
            final stepIndex = index ~/ 2;
            final step = steps[stepIndex];
            final isCompleted = stepIndex < currentIndex;
            final isCurrent = stepIndex == currentIndex;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted
                        ? AppColors.success
                        : isCurrent
                            ? AppColors.primary
                            : AppColors.divider.withValues(alpha: 0.5),
                  ),
                  child: Icon(
                    isCompleted
                        ? Icons.check
                        : _stepIcon(step),
                    size: 16,
                    color: (isCompleted || isCurrent)
                        ? Colors.white
                        : AppColors.textSecondary,
                  ),
                ),
                AppSpacing.verticalXs,
                Text(
                  step.label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: isCurrent
                            ? AppColors.primary
                            : AppColors.textSecondary,
                        fontWeight: isCurrent
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  IconData _stepIcon(BookingStatus status) {
    switch (status) {
      case BookingStatus.pending:
        return Icons.schedule;
      case BookingStatus.confirmed:
        return Icons.thumb_up_alt_outlined;
      case BookingStatus.inProgress:
        return Icons.build;
      case BookingStatus.completed:
        return Icons.check_circle_outline;
      case BookingStatus.cancelled:
        return Icons.cancel_outlined;
    }
  }
}

// ---------------------------------------------------------------------------
// Vehicle info card
// ---------------------------------------------------------------------------

class _VehicleInfoCard extends ConsumerWidget {
  const _VehicleInfoCard({required this.vehicleId});

  final String vehicleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicleAsync = ref.watch(vehicleProvider(vehicleId));

    return vehicleAsync.when(
      loading: () => const Card(
        child: Padding(
          padding: AppSpacing.paddingMd,
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (_, __) => const SizedBox.shrink(),
      data: (vehicle) => Card(
        child: Padding(
          padding: AppSpacing.paddingMd,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Vehicle',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Divider(),
              AppSpacing.verticalSm,
              _InfoRow(
                icon: Icons.directions_car,
                label: 'Vehicle',
                value: '${vehicle.make} ${vehicle.model}',
              ),
              AppSpacing.verticalSm,
              _InfoRow(
                icon: Icons.date_range,
                label: 'Year',
                value: vehicle.year.toString(),
              ),
              if (vehicle.plateNumber != null) ...[
                AppSpacing.verticalSm,
                _InfoRow(
                  icon: Icons.confirmation_number,
                  label: 'Plate',
                  value: vehicle.plateNumber!,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Info row widget
// ---------------------------------------------------------------------------

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.textSecondary),
        AppSpacing.horizontalSm,
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: valueColor,
                ),
          ),
        ),
      ],
    );
  }
}
