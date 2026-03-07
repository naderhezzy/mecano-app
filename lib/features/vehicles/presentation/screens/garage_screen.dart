import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mecano_app/core/extensions/context_extensions.dart';
import 'package:mecano_app/features/vehicles/data/repositories/vehicle_repository.dart';
import 'package:mecano_app/features/vehicles/domain/models/fuel_type.dart';
import 'package:mecano_app/features/vehicles/domain/models/vehicle.dart';
import 'package:mecano_app/features/vehicles/presentation/providers/vehicle_providers.dart';
import 'package:mecano_app/shared/providers/supabase_provider.dart';
import 'package:mecano_app/shared/widgets/app_error.dart';
import 'package:mecano_app/shared/widgets/app_loading.dart';
import 'package:mecano_app/shared/widgets/empty_state.dart';
import 'package:mecano_app/theme/app_spacing.dart';

class GarageScreen extends ConsumerWidget {
  const GarageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(
      supabaseClientProvider.select((c) => c.auth.currentUser?.id),
    );

    if (userId == null) {
      return const Scaffold(
        body: AppError(message: 'Please sign in to view your garage.'),
      );
    }

    final vehiclesAsync = ref.watch(vehiclesProvider(userId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Garage'),
      ),
      body: vehiclesAsync.when(
        loading: () => const AppLoading(message: 'Loading vehicles...'),
        error: (error, _) => AppError(
          message: error.toString(),
          onRetry: () => ref.invalidate(vehiclesProvider(userId)),
        ),
        data: (vehicles) {
          if (vehicles.isEmpty) {
            return EmptyState(
              icon: Icons.directions_car_outlined,
              title: 'No vehicles yet',
              description:
                  'Add your first vehicle to start tracking maintenance.',
              actionLabel: 'Add Vehicle',
              onAction: () => context.push('/garage/add'),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await ref
                  .read(vehicleRepositoryProvider)
                  .syncVehicles(userId);
              ref.invalidate(vehiclesProvider(userId));
            },
            child: ListView.separated(
              padding: AppSpacing.paddingMd,
              itemCount: vehicles.length,
              separatorBuilder: (_, __) => AppSpacing.verticalSm,
              itemBuilder: (context, index) => _VehicleCard(
                vehicle: vehicles[index],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/garage/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _VehicleCard extends StatelessWidget {
  const _VehicleCard({required this.vehicle});

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push('/garage/${vehicle.id}'),
        child: Padding(
          padding: AppSpacing.paddingMd,
          child: Row(
            children: [
              // Vehicle photo or placeholder
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.sm),
                child: SizedBox(
                  width: 72,
                  height: 72,
                  child: vehicle.photoUrls.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: vehicle.photoUrls.first,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => Container(
                            color: context.colorScheme.surfaceContainerHighest,
                            child: const Icon(Icons.directions_car, size: 32),
                          ),
                          errorWidget: (_, __, ___) => Container(
                            color: context.colorScheme.surfaceContainerHighest,
                            child: const Icon(Icons.directions_car, size: 32),
                          ),
                        )
                      : Container(
                          color: context.colorScheme.surfaceContainerHighest,
                          child: Icon(
                            Icons.directions_car,
                            size: 32,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                ),
              ),
              AppSpacing.horizontalMd,
              // Vehicle info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${vehicle.make} ${vehicle.model}',
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (vehicle.isPrimary)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: context.colorScheme.primaryContainer,
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.xs),
                            ),
                            child: Text(
                              'Primary',
                              style: context.textTheme.labelSmall?.copyWith(
                                color:
                                    context.colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ),
                      ],
                    ),
                    AppSpacing.verticalXs,
                    Text(
                      '${vehicle.year}',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    AppSpacing.verticalXs,
                    Row(
                      children: [
                        Icon(
                          Icons.speed,
                          size: 16,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        AppSpacing.horizontalXs,
                        Text(
                          '${_formatMileage(vehicle.mileage)} km',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        AppSpacing.horizontalMd,
                        Icon(
                          _fuelTypeIcon(vehicle.fuelType),
                          size: 16,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        AppSpacing.horizontalXs,
                        Text(
                          _fuelTypeLabel(vehicle.fuelType),
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
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
    if (mileage >= 1000) {
      final formatted = (mileage / 1000).toStringAsFixed(
        mileage % 1000 == 0 ? 0 : 1,
      );
      return '${formatted}k';
    }
    return mileage.toString();
  }
}
