// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'garage_review.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GarageReview {

 String get id; String get garageId; String get userId; int get rating; String? get comment; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of GarageReview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GarageReviewCopyWith<GarageReview> get copyWith => _$GarageReviewCopyWithImpl<GarageReview>(this as GarageReview, _$identity);

  /// Serializes this GarageReview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GarageReview&&(identical(other.id, id) || other.id == id)&&(identical(other.garageId, garageId) || other.garageId == garageId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,garageId,userId,rating,comment,createdAt,updatedAt);

@override
String toString() {
  return 'GarageReview(id: $id, garageId: $garageId, userId: $userId, rating: $rating, comment: $comment, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $GarageReviewCopyWith<$Res>  {
  factory $GarageReviewCopyWith(GarageReview value, $Res Function(GarageReview) _then) = _$GarageReviewCopyWithImpl;
@useResult
$Res call({
 String id, String garageId, String userId, int rating, String? comment, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$GarageReviewCopyWithImpl<$Res>
    implements $GarageReviewCopyWith<$Res> {
  _$GarageReviewCopyWithImpl(this._self, this._then);

  final GarageReview _self;
  final $Res Function(GarageReview) _then;

/// Create a copy of GarageReview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? garageId = null,Object? userId = null,Object? rating = null,Object? comment = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,garageId: null == garageId ? _self.garageId : garageId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [GarageReview].
extension GarageReviewPatterns on GarageReview {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GarageReview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GarageReview() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GarageReview value)  $default,){
final _that = this;
switch (_that) {
case _GarageReview():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GarageReview value)?  $default,){
final _that = this;
switch (_that) {
case _GarageReview() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String garageId,  String userId,  int rating,  String? comment,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GarageReview() when $default != null:
return $default(_that.id,_that.garageId,_that.userId,_that.rating,_that.comment,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String garageId,  String userId,  int rating,  String? comment,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _GarageReview():
return $default(_that.id,_that.garageId,_that.userId,_that.rating,_that.comment,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String garageId,  String userId,  int rating,  String? comment,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _GarageReview() when $default != null:
return $default(_that.id,_that.garageId,_that.userId,_that.rating,_that.comment,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GarageReview implements GarageReview {
  const _GarageReview({required this.id, required this.garageId, required this.userId, required this.rating, this.comment, this.createdAt, this.updatedAt});
  factory _GarageReview.fromJson(Map<String, dynamic> json) => _$GarageReviewFromJson(json);

@override final  String id;
@override final  String garageId;
@override final  String userId;
@override final  int rating;
@override final  String? comment;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of GarageReview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GarageReviewCopyWith<_GarageReview> get copyWith => __$GarageReviewCopyWithImpl<_GarageReview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GarageReviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GarageReview&&(identical(other.id, id) || other.id == id)&&(identical(other.garageId, garageId) || other.garageId == garageId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,garageId,userId,rating,comment,createdAt,updatedAt);

@override
String toString() {
  return 'GarageReview(id: $id, garageId: $garageId, userId: $userId, rating: $rating, comment: $comment, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$GarageReviewCopyWith<$Res> implements $GarageReviewCopyWith<$Res> {
  factory _$GarageReviewCopyWith(_GarageReview value, $Res Function(_GarageReview) _then) = __$GarageReviewCopyWithImpl;
@override @useResult
$Res call({
 String id, String garageId, String userId, int rating, String? comment, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$GarageReviewCopyWithImpl<$Res>
    implements _$GarageReviewCopyWith<$Res> {
  __$GarageReviewCopyWithImpl(this._self, this._then);

  final _GarageReview _self;
  final $Res Function(_GarageReview) _then;

/// Create a copy of GarageReview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? garageId = null,Object? userId = null,Object? rating = null,Object? comment = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_GarageReview(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,garageId: null == garageId ? _self.garageId : garageId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
