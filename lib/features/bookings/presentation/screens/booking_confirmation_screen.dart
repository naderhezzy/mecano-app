import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mecano_app/core/extensions/context_extensions.dart';
import 'package:mecano_app/features/bookings/domain/models/booking_status.dart';
import 'package:mecano_app/features/bookings/presentation/providers/booking_providers.dart';
import 'package:mecano_app/shared/widgets/app_error.dart';
import 'package:mecano_app/shared/widgets/app_loading.dart';
import 'package:mecano_app/theme/app_colors.dart';
import 'package:mecano_app/theme/app_spacing.dart';

class BookingConfirmationScreen extends ConsumerWidget {
  const BookingConfirmationScreen({required this.bookingId, super.key});

  final String bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingAsync = ref.watch(bookingDetailProvider(bookingId));

    return Scaffold(
      body: SafeArea(
        child: bookingAsync.when(
          loading: () => const AppLoading(message: 'Loading booking...'),
          error: (error, _) => AppError(
            message: error.toString(),
            onRetry: () => ref.invalidate(bookingDetailProvider(bookingId)),
          ),
          data: (booking) {
            final dateFormat = DateFormat('EEEE, MMMM d, yyyy');
            final status = BookingStatus.fromString(booking.status);

            return SingleChildScrollView(
              padding: AppSpacing.paddingLg,
              child: Column(
                children: [
                  AppSpacing.verticalXl,

                  // Success icon
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 56,
                    ),
                  ),
                  AppSpacing.verticalLg,

                  // Title
                  Text(
                    'Booking Confirmed!',
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppSpacing.verticalSm,
                  Text(
                    'Your appointment has been submitted successfully.',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  AppSpacing.verticalXl,

                  // Summary card
                  Card(
                    child: Padding(
                      padding: AppSpacing.paddingMd,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Booking Details',
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(),
                          AppSpacing.verticalSm,
                          _DetailRow(
                            label: 'Status',
                            child: Container(
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
                                style: context.textTheme.labelSmall?.copyWith(
                                  color: _statusColor(status),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          AppSpacing.verticalSm,
                          _DetailRow(
                            label: 'Date',
                            child: Text(
                              dateFormat.format(booking.appointmentDate),
                              style: context.textTheme.bodyMedium,
                            ),
                          ),
                          AppSpacing.verticalSm,
                          _DetailRow(
                            label: 'Time',
                            child: Text(
                              booking.appointmentTime,
                              style: context.textTheme.bodyMedium,
                            ),
                          ),
                          if (booking.notes != null &&
                              booking.notes!.isNotEmpty) ...[
                            AppSpacing.verticalSm,
                            _DetailRow(
                              label: 'Notes',
                              child: Text(
                                booking.notes!,
                                style: context.textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  AppSpacing.verticalXl,

                  // Action buttons
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () => context.go('/bookings'),
                      icon: const Icon(Icons.list_alt),
                      label: const Text('View Bookings'),
                    ),
                  ),
                  AppSpacing.verticalSm,
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => context.go('/home'),
                      icon: const Icon(Icons.home),
                      label: const Text('Back to Home'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
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

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ),
        AppSpacing.horizontalSm,
        Expanded(child: child),
      ],
    );
  }
}
