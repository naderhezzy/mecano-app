// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Booking _$BookingFromJson(Map<String, dynamic> json) => _Booking(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  garageId: json['garage_id'] as String,
  vehicleId: json['vehicle_id'] as String,
  serviceCategoryId: json['service_category_id'] as String?,
  status: json['status'] as String,
  appointmentDate: DateTime.parse(json['appointment_date'] as String),
  appointmentTime: json['appointment_time'] as String,
  notes: json['notes'] as String?,
  estimatedCost: (json['estimated_cost'] as num?)?.toDouble(),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$BookingToJson(_Booking instance) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'garage_id': instance.garageId,
  'vehicle_id': instance.vehicleId,
  'service_category_id': instance.serviceCategoryId,
  'status': instance.status,
  'appointment_date': instance.appointmentDate.toIso8601String(),
  'appointment_time': instance.appointmentTime,
  'notes': instance.notes,
  'estimated_cost': instance.estimatedCost,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};
