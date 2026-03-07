import 'package:freezed_annotation/freezed_annotation.dart';

part 'garage_review.freezed.dart';
part 'garage_review.g.dart';

@freezed
class GarageReview with _$GarageReview {
  const factory GarageReview({
    required String id,
    required String garageId,
    required String userId,
    required int rating,
    String? comment,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _GarageReview;

  factory GarageReview.fromJson(Map<String, dynamic> json) =>
      _$GarageReviewFromJson(json);
}
