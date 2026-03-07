import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mecano_app/core/extensions/context_extensions.dart';
import 'package:mecano_app/core/utils/currency_formatter.dart';
import 'package:mecano_app/features/maintenance/data/repositories/maintenance_repository.dart';
import 'package:mecano_app/features/maintenance/domain/models/maintenance_record.dart';
import 'package:mecano_app/theme/app_spacing.dart';
import 'package:timeago/timeago.dart' as timeago;

const _serviceTypeIcons = <String, IconData>{
  'Oil Change': Icons.oil_barrel_outlined,
  'Brakes': Icons.do_not_touch_outlined,
  'Tires': Icons.tire_repair_outlined,
  'Engine': Icons.engineering_outlined,
  'Transmission': Icons.settings_outlined,
  'Electrical': Icons.electrical_services_outlined,
  'A/C': Icons.ac_unit_outlined,
  'Body Work': Icons.car_repair_outlined,
  'Inspection': Icons.checklist_outlined,
  'Battery': Icons.battery_charging_full_outlined,
  'Suspension': Icons.swap_vert_outlined,
  'Exhaust': Icons.air_outlined,
  'Other': Icons.build_outlined,
};

class MaintenanceDetailScreen extends ConsumerWidget {
  const MaintenanceDetailScreen({required this.record, super.key});

  final MaintenanceRecord record;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateFormat = DateFormat.yMMMd();
    final icon =
        _serviceTypeIcons[record.serviceType] ?? Icons.build_outlined;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Maintenance Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Edit',
            onPressed: () {
              // Navigate to edit screen (can be implemented later)
              context.showSnackBar('Edit functionality coming soon');
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outlined),
            tooltip: 'Delete',
            onPressed: () => _confirmDelete(context, ref),
          ),
        ],
      ),
      body: ListView(
        padding: AppSpacing.paddingMd,
        children: [
          // Header card with icon, title, and date
          Card(
            child: Padding(
              padding: AppSpacing.paddingLg,
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: context.colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 32,
                      color: context.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  AppSpacing.verticalMd,
                  Text(
                    record.title,
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  AppSpacing.verticalXs,
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: context.colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(AppSpacing.sm),
                    ),
                    child: Text(
                      record.serviceType,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: context.colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ),
                  AppSpacing.verticalSm,
                  Text(
                    '${dateFormat.format(record.serviceDate)} '
                    '(${timeago.format(record.serviceDate)})',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AppSpacing.verticalMd,

          // Cost & Mileage card
          Card(
            child: Padding(
              padding: AppSpacing.paddingMd,
              child: Row(
                children: [
                  Expanded(
                    child: _StatItem(
                      icon: Icons.payments_outlined,
                      label: 'Cost',
                      value: record.cost != null
                          ? CurrencyFormatter.formatTND(record.cost!)
                          : '--',
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 48,
                    color: context.colorScheme.outlineVariant,
                  ),
                  Expanded(
                    child: _StatItem(
                      icon: Icons.speed_outlined,
                      label: 'Mileage',
                      value: record.mileageAtService != null
                          ? '${record.mileageAtService} km'
                          : '--',
                    ),
                  ),
                ],
              ),
            ),
          ),
          AppSpacing.verticalMd,

          // Next service info
          if (record.nextServiceDate != null ||
              record.nextServiceMileage != null) ...[
            _SectionHeader(title: 'Next Service'),
            Card(
              child: Padding(
                padding: AppSpacing.paddingMd,
                child: Column(
                  children: [
                    if (record.nextServiceDate != null)
                      _InfoRow(
                        icon: Icons.event_outlined,
                        label: 'Date',
                        value: '${dateFormat.format(record.nextServiceDate!)} '
                            '(${timeago.format(
                          record.nextServiceDate!,
                          allowFromNow: true,
                        )})',
                      ),
                    if (record.nextServiceDate != null &&
                        record.nextServiceMileage != null)
                      const Divider(),
                    if (record.nextServiceMileage != null)
                      _InfoRow(
                        icon: Icons.update_outlined,
                        label: 'Mileage',
                        value: '${record.nextServiceMileage} km',
                      ),
                  ],
                ),
              ),
            ),
            AppSpacing.verticalMd,
          ],

          // Details card
          _SectionHeader(title: 'Details'),
          Card(
            child: Padding(
              padding: AppSpacing.paddingMd,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InfoRow(
                    icon: Icons.fingerprint_outlined,
                    label: 'Record ID',
                    value: record.id.substring(0, 8),
                  ),
                  const Divider(),
                  _InfoRow(
                    icon: Icons.directions_car_outlined,
                    label: 'Vehicle ID',
                    value: record.vehicleId.substring(0, 8),
                  ),
                  if (record.garageId != null) ...[
                    const Divider(),
                    _InfoRow(
                      icon: Icons.store_outlined,
                      label: 'Garage',
                      value: record.garageId!,
                    ),
                  ],
                  if (record.createdAt != null) ...[
                    const Divider(),
                    _InfoRow(
                      icon: Icons.access_time_outlined,
                      label: 'Created',
                      value: dateFormat.format(record.createdAt!),
                    ),
                  ],
                  if (record.updatedAt != null) ...[
                    const Divider(),
                    _InfoRow(
                      icon: Icons.update_outlined,
                      label: 'Updated',
                      value: dateFormat.format(record.updatedAt!),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Notes card
          if (record.notes != null && record.notes!.isNotEmpty) ...[
            AppSpacing.verticalMd,
            _SectionHeader(title: 'Notes'),
            Card(
              child: Padding(
                padding: AppSpacing.paddingMd,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.notes_outlined,
                      size: 20,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    AppSpacing.horizontalSm,
                    Expanded(
                      child: Text(
                        record.notes!,
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          // Photos section
          if (record.photoUrls.isNotEmpty) ...[
            AppSpacing.verticalMd,
            _SectionHeader(title: 'Photos'),
            SizedBox(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: record.photoUrls.length,
                separatorBuilder: (_, __) => AppSpacing.horizontalSm,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(AppSpacing.sm),
                    child: Image.network(
                      record.photoUrls[index],
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 120,
                        height: 120,
                        color: context.colorScheme.surfaceContainerHighest,
                        child: Icon(
                          Icons.broken_image_outlined,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],

          AppSpacing.verticalXl,
        ],
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Record'),
        content: const Text(
          'Are you sure you want to delete this maintenance record? '
          'This action cannot be undone.',
        ),
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
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    final result = await ref
        .read(maintenanceRepositoryProvider)
        .deleteMaintenanceRecord(record.id);

    if (!context.mounted) return;

    result.fold(
      (error) => context.showSnackBar(error.message, isError: true),
      (_) {
        context.showSnackBar('Maintenance record deleted');
        context.pop();
      },
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

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: context.colorScheme.onSurfaceVariant,
          ),
          AppSpacing.horizontalSm,
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: context.colorScheme.primary),
        AppSpacing.verticalXs,
        Text(
          label,
          style: context.textTheme.labelSmall?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
