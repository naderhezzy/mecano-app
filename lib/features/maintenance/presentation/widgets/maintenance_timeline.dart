import 'package:flutter/material.dart';
import 'package:mecano_app/core/extensions/context_extensions.dart';
import 'package:mecano_app/core/utils/currency_formatter.dart';
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

class MaintenanceTimeline extends StatefulWidget {
  const MaintenanceTimeline({
    required this.records,
    this.onRecordTap,
    super.key,
  });

  final List<MaintenanceRecord> records;
  final ValueChanged<MaintenanceRecord>? onRecordTap;

  @override
  State<MaintenanceTimeline> createState() => _MaintenanceTimelineState();
}

class _MaintenanceTimelineState extends State<MaintenanceTimeline> {
  String? _expandedId;

  @override
  Widget build(BuildContext context) {
    if (widget.records.isEmpty) {
      return Center(
        child: Padding(
          padding: AppSpacing.paddingLg,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.build_circle_outlined,
                size: 80,
                color: context.colorScheme.outline,
              ),
              AppSpacing.verticalMd,
              Text(
                'No maintenance records yet',
                style: context.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              AppSpacing.verticalSm,
              Text(
                'Add your first maintenance record to start tracking '
                'your vehicle service history.',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    // Sort by date descending (newest first)
    final sorted = List<MaintenanceRecord>.from(widget.records)
      ..sort((a, b) => b.serviceDate.compareTo(a.serviceDate));

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sorted.length,
      itemBuilder: (context, index) {
        final record = sorted[index];
        final isLast = index == sorted.length - 1;
        final isExpanded = _expandedId == record.id;

        return _TimelineItem(
          record: record,
          isLast: isLast,
          isExpanded: isExpanded,
          onTap: () {
            setState(() {
              _expandedId = isExpanded ? null : record.id;
            });
            widget.onRecordTap?.call(record);
          },
        );
      },
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.record,
    required this.isLast,
    required this.isExpanded,
    required this.onTap,
  });

  final MaintenanceRecord record;
  final bool isLast;
  final bool isExpanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final icon =
        _serviceTypeIcons[record.serviceType] ?? Icons.build_outlined;

    return InkWell(
      onTap: onTap,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline line & dot
            SizedBox(
              width: 48,
              child: Column(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: context.colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 18,
                      color: context.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        color: context.colorScheme.outlineVariant,
                      ),
                    ),
                ],
              ),
            ),
            // Content card
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: AppSpacing.md,
                ),
                child: Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: AppSpacing.paddingMd,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header row
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                record.title,
                                style:
                                    context.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Icon(
                              isExpanded
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                              size: 20,
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ],
                        ),
                        AppSpacing.verticalXs,

                        // Date
                        Text(
                          timeago.format(record.serviceDate),
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),

                        // Cost & Mileage summary row
                        AppSpacing.verticalSm,
                        Row(
                          children: [
                            if (record.cost != null) ...[
                              Icon(
                                Icons.payments_outlined,
                                size: 14,
                                color: context.colorScheme.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                CurrencyFormatter.formatTND(record.cost!),
                                style:
                                    context.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: context.colorScheme.primary,
                                ),
                              ),
                              AppSpacing.horizontalMd,
                            ],
                            if (record.mileageAtService != null) ...[
                              Icon(
                                Icons.speed_outlined,
                                size: 14,
                                color:
                                    context.colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${record.mileageAtService} km',
                                style:
                                    context.textTheme.bodySmall?.copyWith(
                                  color: context
                                      .colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ],
                        ),

                        // Expanded details
                        if (isExpanded) ...[
                          const Divider(height: AppSpacing.lg),
                          _DetailRow(
                            label: 'Service Type',
                            value: record.serviceType,
                          ),
                          if (record.garageId != null)
                            _DetailRow(
                              label: 'Garage',
                              value: record.garageId!,
                            ),
                          if (record.nextServiceDate != null)
                            _DetailRow(
                              label: 'Next Service',
                              value: timeago.format(
                                record.nextServiceDate!,
                                allowFromNow: true,
                              ),
                            ),
                          if (record.nextServiceMileage != null)
                            _DetailRow(
                              label: 'Next at Mileage',
                              value: '${record.nextServiceMileage} km',
                            ),
                          if (record.notes != null &&
                              record.notes!.isNotEmpty) ...[
                            AppSpacing.verticalSm,
                            Text(
                              'Notes',
                              style:
                                  context.textTheme.labelSmall?.copyWith(
                                color:
                                    context.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              record.notes!,
                              style: context.textTheme.bodySmall,
                            ),
                          ],
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        children: [
          SizedBox(
            width: 120,
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
              style: context.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
