import 'package:freezed_annotation/freezed_annotation.dart';

part 'garage_service.freezed.dart';
part 'garage_service.g.dart';

@freezed
class GarageService with _$GarageService {
  const factory GarageService({
    required String id,
    required String garageId,
    required String serviceCategoryId,
    double? priceMin,
    double? priceMax,
    int? estimatedDuration,
  }) = _GarageService;

  factory GarageService.fromJson(Map<String, dynamic> json) =>
      _$GarageServiceFromJson(json);
}
