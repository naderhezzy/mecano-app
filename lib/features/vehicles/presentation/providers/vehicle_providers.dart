import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mecano_app/features/vehicles/data/repositories/vehicle_repository.dart';
import 'package:mecano_app/features/vehicles/domain/models/vehicle.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vehicle_providers.g.dart';

@riverpod
Stream<List<Vehicle>> vehicles(Ref ref, String userId) {
  final repo = ref.watch(vehicleRepositoryProvider);
  return repo.watchVehicles(userId);
}

@riverpod
Future<Vehicle> vehicle(Ref ref, String id) async {
  final repo = ref.watch(vehicleRepositoryProvider);
  final result = await repo.getVehicle(id);
  return result.fold(
    (error) => throw error,
    (vehicle) => vehicle,
  );
}

@riverpod
Stream<Vehicle?> primaryVehicle(Ref ref, String userId) {
  final repo = ref.watch(vehicleRepositoryProvider);
  return repo.watchVehicles(userId).map(
    (vehicles) {
      try {
        return vehicles.firstWhere((v) => v.isPrimary);
      } catch (_) {
        return vehicles.isNotEmpty ? vehicles.first : null;
      }
    },
  );
}
