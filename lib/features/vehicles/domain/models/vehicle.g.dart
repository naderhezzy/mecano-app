// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Vehicle _$VehicleFromJson(Map<String, dynamic> json) => _Vehicle(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  make: json['make'] as String,
  model: json['model'] as String,
  year: (json['year'] as num).toInt(),
  mileage: (json['mileage'] as num).toInt(),
  vin: json['vin'] as String?,
  fuelType: json['fuel_type'] as String,
  plateNumber: json['plate_number'] as String?,
  color: json['color'] as String?,
  photoUrls:
      (json['photo_urls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  notes: json['notes'] as String?,
  isPrimary: json['is_primary'] as bool? ?? false,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$VehicleToJson(_Vehicle instance) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'make': instance.make,
  'model': instance.model,
  'year': instance.year,
  'mileage': instance.mileage,
  'vin': instance.vin,
  'fuel_type': instance.fuelType,
  'plate_number': instance.plateNumber,
  'color': instance.color,
  'photo_urls': instance.photoUrls,
  'notes': instance.notes,
  'is_primary': instance.isPrimary,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};
