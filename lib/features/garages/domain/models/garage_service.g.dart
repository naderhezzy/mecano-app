// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garage_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GarageService _$GarageServiceFromJson(Map<String, dynamic> json) =>
    _GarageService(
      id: json['id'] as String,
      garageId: json['garage_id'] as String,
      serviceCategoryId: json['service_category_id'] as String,
      priceMin: (json['price_min'] as num?)?.toDouble(),
      priceMax: (json['price_max'] as num?)?.toDouble(),
      estimatedDuration: (json['estimated_duration'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GarageServiceToJson(_GarageService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'garage_id': instance.garageId,
      'service_category_id': instance.serviceCategoryId,
      'price_min': instance.priceMin,
      'price_max': instance.priceMax,
      'estimated_duration': instance.estimatedDuration,
    };
