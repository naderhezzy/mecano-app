import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking.freezed.dart';
part 'booking.g.dart';

@freezed
class Booking with _$Booking {
  const factory Booking({
    required String id,
    required String userId,
    required String garageId,
    required String vehicleId,
    String? serviceCategoryId,
    required String status,
    required DateTime appointmentDate,
    required String appointmentTime,
    String? notes,
    double? estimatedCost,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Booking;

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);
}
