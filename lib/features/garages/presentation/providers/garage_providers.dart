import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mecano_app/features/garages/data/repositories/garage_repository.dart';
import 'package:mecano_app/features/garages/domain/models/garage.dart';
import 'package:mecano_app/features/garages/domain/models/garage_review.dart';
import 'package:mecano_app/features/garages/domain/models/garage_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'garage_providers.g.dart';

@riverpod
Future<List<Garage>> garages(
  Ref ref,
  String? city,
  String? search,
) async {
  final repo = ref.watch(garageRepositoryProvider);
  final result = await repo.getGarages(city: city, searchQuery: search);
  return result.fold(
    (error) => throw error,
    (garages) => garages,
  );
}

@riverpod
Future<Garage> garageDetail(Ref ref, String garageId) async {
  final repo = ref.watch(garageRepositoryProvider);
  final result = await repo.getGarage(garageId);
  return result.fold(
    (error) => throw error,
    (garage) => garage,
  );
}

@riverpod
Future<List<GarageService>> garageServices(
  Ref ref,
  String garageId,
) async {
  final repo = ref.watch(garageRepositoryProvider);
  final result = await repo.getGarageServices(garageId);
  return result.fold(
    (error) => throw error,
    (services) => services,
  );
}

@riverpod
Future<List<GarageReview>> garageReviews(
  Ref ref,
  String garageId,
) async {
  final repo = ref.watch(garageRepositoryProvider);
  final result = await repo.getGarageReviews(garageId);
  return result.fold(
    (error) => throw error,
    (reviews) => reviews,
  );
}

@riverpod
Future<List<String>> garageCities(Ref ref) async {
  final repo = ref.watch(garageRepositoryProvider);
  final result = await repo.getCities();
  return result.fold(
    (error) => throw error,
    (cities) => cities,
  );
}
