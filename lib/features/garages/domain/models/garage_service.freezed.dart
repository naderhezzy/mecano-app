// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'garage_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GarageService {

 String get id; String get garageId; String get serviceCategoryId; double? get priceMin; double? get priceMax; int? get estimatedDuration;
/// Create a copy of GarageService
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GarageServiceCopyWith<GarageService> get copyWith => _$GarageServiceCopyWithImpl<GarageService>(this as GarageService, _$identity);

  /// Serializes this GarageService to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GarageService&&(identical(other.id, id) || other.id == id)&&(identical(other.garageId, garageId) || other.garageId == garageId)&&(identical(other.serviceCategoryId, serviceCategoryId) || other.serviceCategoryId == serviceCategoryId)&&(identical(other.priceMin, priceMin) || other.priceMin == priceMin)&&(identical(other.priceMax, priceMax) || other.priceMax == priceMax)&&(identical(other.estimatedDuration, estimatedDuration) || other.estimatedDuration == estimatedDuration));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,garageId,serviceCategoryId,priceMin,priceMax,estimatedDuration);

@override
String toString() {
  return 'GarageService(id: $id, garageId: $garageId, serviceCategoryId: $serviceCategoryId, priceMin: $priceMin, priceMax: $priceMax, estimatedDuration: $estimatedDuration)';
}


}

/// @nodoc
abstract mixin class $GarageServiceCopyWith<$Res>  {
  factory $GarageServiceCopyWith(GarageService value, $Res Function(GarageService) _then) = _$GarageServiceCopyWithImpl;
@useResult
$Res call({
 String id, String garageId, String serviceCategoryId, double? priceMin, double? priceMax, int? estimatedDuration
});




}
/// @nodoc
class _$GarageServiceCopyWithImpl<$Res>
    implements $GarageServiceCopyWith<$Res> {
  _$GarageServiceCopyWithImpl(this._self, this._then);

  final GarageService _self;
  final $Res Function(GarageService) _then;

/// Create a copy of GarageService
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? garageId = null,Object? serviceCategoryId = null,Object? priceMin = freezed,Object? priceMax = freezed,Object? estimatedDuration = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,garageId: null == garageId ? _self.garageId : garageId // ignore: cast_nullable_to_non_nullable
as String,serviceCategoryId: null == serviceCategoryId ? _self.serviceCategoryId : serviceCategoryId // ignore: cast_nullable_to_non_nullable
as String,priceMin: freezed == priceMin ? _self.priceMin : priceMin // ignore: cast_nullable_to_non_nullable
as double?,priceMax: freezed == priceMax ? _self.priceMax : priceMax // ignore: cast_nullable_to_non_nullable
as double?,estimatedDuration: freezed == estimatedDuration ? _self.estimatedDuration : estimatedDuration // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [GarageService].
extension GarageServicePatterns on GarageService {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GarageService value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GarageService() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GarageService value)  $default,){
final _that = this;
switch (_that) {
case _GarageService():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GarageService value)?  $default,){
final _that = this;
switch (_that) {
case _GarageService() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String garageId,  String serviceCategoryId,  double? priceMin,  double? priceMax,  int? estimatedDuration)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GarageService() when $default != null:
return $default(_that.id,_that.garageId,_that.serviceCategoryId,_that.priceMin,_that.priceMax,_that.estimatedDuration);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String garageId,  String serviceCategoryId,  double? priceMin,  double? priceMax,  int? estimatedDuration)  $default,) {final _that = this;
switch (_that) {
case _GarageService():
return $default(_that.id,_that.garageId,_that.serviceCategoryId,_that.priceMin,_that.priceMax,_that.estimatedDuration);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String garageId,  String serviceCategoryId,  double? priceMin,  double? priceMax,  int? estimatedDuration)?  $default,) {final _that = this;
switch (_that) {
case _GarageService() when $default != null:
return $default(_that.id,_that.garageId,_that.serviceCategoryId,_that.priceMin,_that.priceMax,_that.estimatedDuration);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GarageService implements GarageService {
  const _GarageService({required this.id, required this.garageId, required this.serviceCategoryId, this.priceMin, this.priceMax, this.estimatedDuration});
  factory _GarageService.fromJson(Map<String, dynamic> json) => _$GarageServiceFromJson(json);

@override final  String id;
@override final  String garageId;
@override final  String serviceCategoryId;
@override final  double? priceMin;
@override final  double? priceMax;
@override final  int? estimatedDuration;

/// Create a copy of GarageService
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GarageServiceCopyWith<_GarageService> get copyWith => __$GarageServiceCopyWithImpl<_GarageService>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GarageServiceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GarageService&&(identical(other.id, id) || other.id == id)&&(identical(other.garageId, garageId) || other.garageId == garageId)&&(identical(other.serviceCategoryId, serviceCategoryId) || other.serviceCategoryId == serviceCategoryId)&&(identical(other.priceMin, priceMin) || other.priceMin == priceMin)&&(identical(other.priceMax, priceMax) || other.priceMax == priceMax)&&(identical(other.estimatedDuration, estimatedDuration) || other.estimatedDuration == estimatedDuration));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,garageId,serviceCategoryId,priceMin,priceMax,estimatedDuration);

@override
String toString() {
  return 'GarageService(id: $id, garageId: $garageId, serviceCategoryId: $serviceCategoryId, priceMin: $priceMin, priceMax: $priceMax, estimatedDuration: $estimatedDuration)';
}


}

/// @nodoc
abstract mixin class _$GarageServiceCopyWith<$Res> implements $GarageServiceCopyWith<$Res> {
  factory _$GarageServiceCopyWith(_GarageService value, $Res Function(_GarageService) _then) = __$GarageServiceCopyWithImpl;
@override @useResult
$Res call({
 String id, String garageId, String serviceCategoryId, double? priceMin, double? priceMax, int? estimatedDuration
});




}
/// @nodoc
class __$GarageServiceCopyWithImpl<$Res>
    implements _$GarageServiceCopyWith<$Res> {
  __$GarageServiceCopyWithImpl(this._self, this._then);

  final _GarageService _self;
  final $Res Function(_GarageService) _then;

/// Create a copy of GarageService
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? garageId = null,Object? serviceCategoryId = null,Object? priceMin = freezed,Object? priceMax = freezed,Object? estimatedDuration = freezed,}) {
  return _then(_GarageService(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,garageId: null == garageId ? _self.garageId : garageId // ignore: cast_nullable_to_non_nullable
as String,serviceCategoryId: null == serviceCategoryId ? _self.serviceCategoryId : serviceCategoryId // ignore: cast_nullable_to_non_nullable
as String,priceMin: freezed == priceMin ? _self.priceMin : priceMin // ignore: cast_nullable_to_non_nullable
as double?,priceMax: freezed == priceMax ? _self.priceMax : priceMax // ignore: cast_nullable_to_non_nullable
as double?,estimatedDuration: freezed == estimatedDuration ? _self.estimatedDuration : estimatedDuration // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
