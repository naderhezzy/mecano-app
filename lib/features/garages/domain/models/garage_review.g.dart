// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garage_review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GarageReview _$GarageReviewFromJson(Map<String, dynamic> json) =>
    _GarageReview(
      id: json['id'] as String,
      garageId: json['garage_id'] as String,
      userId: json['user_id'] as String,
      rating: (json['rating'] as num).toInt(),
      comment: json['comment'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$GarageReviewToJson(_GarageReview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'garage_id': instance.garageId,
      'user_id': instance.userId,
      'rating': instance.rating,
      'comment': instance.comment,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
