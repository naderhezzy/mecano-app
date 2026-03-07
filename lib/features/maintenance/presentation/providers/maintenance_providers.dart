import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mecano_app/features/maintenance/data/repositories/maintenance_repository.dart';
import 'package:mecano_app/features/maintenance/domain/models/maintenance_record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'maintenance_providers.g.dart';

@riverpod
Stream<List<MaintenanceRecord>> vehicleMaintenance(
  Ref ref,
  String vehicleId,
) {
  final repo = ref.watch(maintenanceRepositoryProvider);
  return repo.watchMaintenanceForVehicle(vehicleId);
}

@riverpod
Future<List<MaintenanceRecord>> upcomingMaintenance(
  Ref ref,
  String userId,
) async {
  final repo = ref.watch(maintenanceRepositoryProvider);
  final result = await repo.getUpcomingMaintenance(userId);
  return result.fold(
    (error) => throw error,
    (records) => records,
  );
}
