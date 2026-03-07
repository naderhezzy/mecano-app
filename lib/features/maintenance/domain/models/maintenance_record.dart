import 'package:freezed_annotation/freezed_annotation.dart';

part 'maintenance_record.freezed.dart';
part 'maintenance_record.g.dart';

@freezed
class MaintenanceRecord with _$MaintenanceRecord {
  const factory MaintenanceRecord({
    required String id,
    required String vehicleId,
    required String serviceType,
    required String title,
    int? mileageAtService,
    double? cost,
    required DateTime serviceDate,
    String? garageId,
    DateTime? nextServiceDate,
    int? nextServiceMileage,
    String? notes,
    @Default([]) List<String> photoUrls,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _MaintenanceRecord;

  factory MaintenanceRecord.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceRecordFromJson(json);
}
