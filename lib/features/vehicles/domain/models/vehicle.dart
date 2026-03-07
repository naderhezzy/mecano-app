import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle.freezed.dart';
part 'vehicle.g.dart';

@freezed
abstract class Vehicle with _$Vehicle {
  const factory Vehicle({
    required String id,
    required String userId,
    required String make,
    required String model,
    required int year,
    required int mileage,
    String? vin,
    required String fuelType,
    String? plateNumber,
    String? color,
    @Default([]) List<String> photoUrls,
    String? notes,
    @Default(false) bool isPrimary,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Vehicle;

  factory Vehicle.fromJson(Map<String, dynamic> json) =>
      _$VehicleFromJson(json);
}
