// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Garage _$GarageFromJson(Map<String, dynamic> json) => _Garage(
  id: json['id'] as String,
  name: json['name'] as String,
  address: json['address'] as String,
  city: json['city'] as String,
  lat: (json['lat'] as num?)?.toDouble(),
  lng: (json['lng'] as num?)?.toDouble(),
  phone: json['phone'] as String?,
  photoUrls:
      (json['photo_urls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  averageRating: (json['average_rating'] as num?)?.toDouble() ?? 0.0,
  totalReviews: (json['total_reviews'] as num?)?.toInt() ?? 0,
  isVerified: json['is_verified'] as bool? ?? false,
  workingHours: json['working_hours'] as Map<String, dynamic>? ?? const {},
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$GarageToJson(_Garage instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'address': instance.address,
  'city': instance.city,
  'lat': instance.lat,
  'lng': instance.lng,
  'phone': instance.phone,
  'photo_urls': instance.photoUrls,
  'average_rating': instance.averageRating,
  'total_reviews': instance.totalReviews,
  'is_verified': instance.isVerified,
  'working_hours': instance.workingHours,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};
