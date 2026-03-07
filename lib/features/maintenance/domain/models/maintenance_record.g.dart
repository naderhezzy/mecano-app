// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MaintenanceRecord _$MaintenanceRecordFromJson(Map<String, dynamic> json) =>
    _MaintenanceRecord(
      id: json['id'] as String,
      vehicleId: json['vehicle_id'] as String,
      serviceType: json['service_type'] as String,
      title: json['title'] as String,
      mileageAtService: (json['mileage_at_service'] as num?)?.toInt(),
      cost: (json['cost'] as num?)?.toDouble(),
      serviceDate: DateTime.parse(json['service_date'] as String),
      garageId: json['garage_id'] as String?,
      nextServiceDate: json['next_service_date'] == null
          ? null
          : DateTime.parse(json['next_service_date'] as String),
      nextServiceMileage: (json['next_service_mileage'] as num?)?.toInt(),
      notes: json['notes'] as String?,
      photoUrls:
          (json['photo_urls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$MaintenanceRecordToJson(_MaintenanceRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vehicle_id': instance.vehicleId,
      'service_type': instance.serviceType,
      'title': instance.title,
      'mileage_at_service': instance.mileageAtService,
      'cost': instance.cost,
      'service_date': instance.serviceDate.toIso8601String(),
      'garage_id': instance.garageId,
      'next_service_date': instance.nextServiceDate?.toIso8601String(),
      'next_service_mileage': instance.nextServiceMileage,
      'notes': instance.notes,
      'photo_urls': instance.photoUrls,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
