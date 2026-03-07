import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mecano_app/core/extensions/context_extensions.dart';
import 'package:mecano_app/features/vehicles/data/repositories/vehicle_repository.dart';
import 'package:mecano_app/features/vehicles/domain/models/fuel_type.dart';
import 'package:mecano_app/features/vehicles/domain/models/vehicle.dart';
import 'package:mecano_app/features/vehicles/presentation/providers/vehicle_providers.dart';
import 'package:mecano_app/shared/widgets/app_error.dart';
import 'package:mecano_app/shared/widgets/app_loading.dart';
import 'package:mecano_app/theme/app_spacing.dart';

class VehicleDetailScreen extends ConsumerWidget {
  const VehicleDetailScreen({required this.vehicleId, super.key});

  final String vehicleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicleAsync = ref.watch(vehicleProvider(vehicleId));

    return vehicleAsync.when(
      loading: () => const Scaffold(
        body: AppLoading(message: 'Loading vehicle...'),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(),
        body: AppError(
          message: error.toString(),
          onRetry: () => ref.invalidate(vehicleProvider(vehicleId)),
        ),
      ),
      data: (vehicle) => _VehicleDetailView(
        vehicle: vehicle,
        vehicleId: vehicleId,
      ),
    );
  }
}

class _VehicleDetailView extends ConsumerWidget {
  const _VehicleDetailView({
    required this.vehicle,
    required this.vehicleId,
  });

  final Vehicle vehicle;
  final String vehicleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Hero image app bar
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            actions: [
              IconButton(
                onPressed: () =>
                    context.push('/garage/$vehicleId/edit'),
                icon: const Icon(Icons.edit_outlined),
                tooltip: 'Edit vehicle',
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                '${vehicle.make} ${vehicle.model}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  shadows: [
                    Shadow(
                      blurRadius: 8,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
              background: vehicle.photoUrls.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: vehicle.photoUrls.first,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(
                        color:
                            context.colorScheme.surfaceContainerHighest,
                        child: const Center(
                          child: Icon(
                            Icons.directions_car,
                            size: 80,
                          ),
                        ),
                      ),
                      errorWidget: (_, __, ___) => Container(
                        color:
                            context.colorScheme.surfaceContainerHighest,
                        child: const Center(
                          child: Icon(
                            Icons.directions_car,
                            size: 80,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      color: context.colorScheme.surfaceContainerHighest,
                      child: Center(
                        child: Icon(
                          Icons.directions_car,
                          size: 80,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: AppSpacing.paddingMd,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Year subtitle
                  Text(
                    '${vehicle.year}',
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  AppSpacing.verticalMd,

                  // Stats row
                  _buildStatsRow(context),
                  AppSpacing.verticalLg,

                  // Primary vehicle section
                  _buildPrimarySection(context, ref),
                  AppSpacing.verticalLg,

                  // Vehicle details card
                  _buildDetailsCard(context),
                  AppSpacing.verticalLg,

                  // Maintenance section
                  _buildMaintenanceSection(context),
                  AppSpacing.verticalLg,

                  // Documents section
                  _buildDocumentsSection(context),
                  AppSpacing.verticalLg,

                  // Quick actions
                  _buildQuickActions(context, ref),
                  AppSpacing.verticalXl,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    return Row(
      children: [
        _StatChip(
          icon: Icons.speed,
          label: '${_formatMileage(vehicle.mileage)} km',
        ),
        AppSpacing.horizontalSm,
        _StatChip(
          icon: _fuelTypeIcon(vehicle.fuelType),
          label: _fuelTypeLabel(vehicle.fuelType),
        ),
        if (vehicle.plateNumber != null) ...[
          AppSpacing.horizontalSm,
          _StatChip(
            icon: Icons.badge,
            label: vehicle.plateNumber!,
          ),
        ],
      ],
    );
  }

  Widget _buildPrimarySection(BuildContext context, WidgetRef ref) {
    if (vehicle.isPrimary) {
      return Container(
        width: double.infinity,
        padding: AppSpacing.paddingMd,
        decoration: BoxDecoration(
          color: context.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(AppSpacing.sm),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star,
              color: context.colorScheme.onPrimaryContainer,
              size: 20,
            ),
            AppSpacing.horizontalSm,
            Text(
              'Primary Vehicle',
              style: context.textTheme.titleSmall?.copyWith(
                color: context.colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => _handleSetPrimary(context, ref),
        icon: const Icon(Icons.star_outline),
        label: const Text('Set as Primary Vehicle'),
      ),
    );
  }

  Widget _buildDetailsCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: AppSpacing.paddingMd,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vehicle Details',
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            AppSpacing.verticalMd,
            if (vehicle.vin != null)
              _DetailRow(label: 'VIN', value: vehicle.vin!),
            if (vehicle.color != null)
              _DetailRow(label: 'Color', value: vehicle.color!),
            _DetailRow(
              label: 'Fuel Type',
              value: _fuelTypeLabel(vehicle.fuelType),
            ),
            _DetailRow(
              label: 'Year',
              value: vehicle.year.toString(),
            ),
            _DetailRow(
              label: 'Mileage',
              value: '${_formatMileage(vehicle.mileage)} km',
            ),
            if (vehicle.plateNumber != null)
              _DetailRow(
                label: 'Plate Number',
                value: vehicle.plateNumber!,
              ),
            if (vehicle.notes != null) ...[
              AppSpacing.verticalSm,
              Text(
                'Notes',
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              AppSpacing.verticalXs,
              Text(
                vehicle.notes!,
                style: context.textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMaintenanceSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Maintenance History',
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton.icon(
              onPressed: () =>
                  context.push('/garage/$vehicleId/maintenance/add'),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add'),
            ),
          ],
        ),
        AppSpacing.verticalSm,
        Card(
          child: Padding(
            padding: AppSpacing.paddingLg,
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.build_outlined,
                    size: 48,
                    color: context.colorScheme.outline,
                  ),
                  AppSpacing.verticalSm,
                  Text(
                    'No maintenance records yet',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  AppSpacing.verticalSm,
                  TextButton(
                    onPressed: () => context
                        .push('/garage/$vehicleId/maintenance/add'),
                    child: const Text('Log your first service'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Documents',
          style: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        AppSpacing.verticalSm,
        Card(
          child: Padding(
            padding: AppSpacing.paddingLg,
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.folder_outlined,
                    size: 48,
                    color: context.colorScheme.outline,
                  ),
                  AppSpacing.verticalSm,
                  Text(
                    'No documents yet',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  AppSpacing.verticalSm,
                  Text(
                    'Insurance, registration and other documents',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        AppSpacing.verticalSm,
        Row(
          children: [
            Expanded(
              child: _QuickActionButton(
                icon: Icons.edit_outlined,
                label: 'Edit',
                onTap: () =>
                    context.push('/garage/$vehicleId/edit'),
              ),
            ),
            AppSpacing.horizontalSm,
            Expanded(
              child: _QuickActionButton(
                icon: Icons.build_outlined,
                label: 'Log Service',
                onTap: () => context
                    .push('/garage/$vehicleId/maintenance/add'),
              ),
            ),
            AppSpacing.horizontalSm,
            Expanded(
              child: _QuickActionButton(
                icon: Icons.delete_outline,
                label: 'Delete',
                isDestructive: true,
                onTap: () => _handleDelete(context, ref),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _handleSetPrimary(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final result = await ref
        .read(vehicleRepositoryProvider)
        .setPrimaryVehicle(vehicleId, vehicle.userId);

    if (!context.mounted) return;

    result.fold(
      (error) => context.showSnackBar(error.message, isError: true),
      (_) {
        ref.invalidate(vehicleProvider(vehicleId));
        ref.invalidate(vehiclesProvider(vehicle.userId));
        context.showSnackBar('Set as primary vehicle');
      },
    );
  }

  Future<void> _handleDelete(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Vehicle'),
        content: const Text(
          'Are you sure you want to delete this vehicle? '
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

    final result =
        await ref.read(vehicleRepositoryProvider).deleteVehicle(vehicleId);

    if (!context.mounted) return;

    result.fold(
      (error) => context.showSnackBar(error.message, isError: true),
      (_) {
        ref.invalidate(vehiclesProvider(vehicle.userId));
        context.showSnackBar('Vehicle deleted');
        context.go('/garage');
      },
    );
  }

  IconData _fuelTypeIcon(String fuelType) {
    switch (fuelType) {
      case 'electric':
        return Icons.electric_car;
      case 'hybrid':
        return Icons.electric_bolt;
      case 'diesel':
        return Icons.local_gas_station;
      case 'lpg':
        return Icons.propane_tank;
      case 'gasoline':
      default:
        return Icons.local_gas_station;
    }
  }

  String _fuelTypeLabel(String fuelType) {
    try {
      return FuelType.values
          .firstWhere((e) => e.name == fuelType)
          .label;
    } catch (_) {
      return fuelType;
    }
  }

  String _formatMileage(int mileage) {
    // Format with thousands separator
    final str = mileage.toString();
    final result = StringBuffer();
    for (var i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) {
        result.write(',');
      }
      result.write(str[i]);
    }
    return result.toString();
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppSpacing.xl),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          AppSpacing.horizontalXs,
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
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
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color:
                        Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive
        ? Theme.of(context).colorScheme.error
        : Theme.of(context).colorScheme.primary;

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.md,
            horizontal: AppSpacing.sm,
          ),
          child: Column(
            children: [
              Icon(icon, color: color),
              AppSpacing.verticalXs,
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
