import 'package:freezed_annotation/freezed_annotation.dart';

part 'garage.freezed.dart';
part 'garage.g.dart';

@freezed
class Garage with _$Garage {
  const factory Garage({
    required String id,
    required String name,
    required String address,
    required String city,
    double? lat,
    double? lng,
    String? phone,
    @Default([]) List<String> photoUrls,
    @Default(0.0) double averageRating,
    @Default(0) int totalReviews,
    @Default(false) bool isVerified,
    @Default({}) Map<String, dynamic> workingHours,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Garage;

  factory Garage.fromJson(Map<String, dynamic> json) => _$GarageFromJson(json);
}
