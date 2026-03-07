// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'maintenance_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MaintenanceRecord {

 String get id; String get vehicleId; String get serviceType; String get title; int? get mileageAtService; double? get cost; DateTime get serviceDate; String? get garageId; DateTime? get nextServiceDate; int? get nextServiceMileage; String? get notes; List<String> get photoUrls; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of MaintenanceRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MaintenanceRecordCopyWith<MaintenanceRecord> get copyWith => _$MaintenanceRecordCopyWithImpl<MaintenanceRecord>(this as MaintenanceRecord, _$identity);

  /// Serializes this MaintenanceRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MaintenanceRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.vehicleId, vehicleId) || other.vehicleId == vehicleId)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.title, title) || other.title == title)&&(identical(other.mileageAtService, mileageAtService) || other.mileageAtService == mileageAtService)&&(identical(other.cost, cost) || other.cost == cost)&&(identical(other.serviceDate, serviceDate) || other.serviceDate == serviceDate)&&(identical(other.garageId, garageId) || other.garageId == garageId)&&(identical(other.nextServiceDate, nextServiceDate) || other.nextServiceDate == nextServiceDate)&&(identical(other.nextServiceMileage, nextServiceMileage) || other.nextServiceMileage == nextServiceMileage)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other.photoUrls, photoUrls)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,vehicleId,serviceType,title,mileageAtService,cost,serviceDate,garageId,nextServiceDate,nextServiceMileage,notes,const DeepCollectionEquality().hash(photoUrls),createdAt,updatedAt);

@override
String toString() {
  return 'MaintenanceRecord(id: $id, vehicleId: $vehicleId, serviceType: $serviceType, title: $title, mileageAtService: $mileageAtService, cost: $cost, serviceDate: $serviceDate, garageId: $garageId, nextServiceDate: $nextServiceDate, nextServiceMileage: $nextServiceMileage, notes: $notes, photoUrls: $photoUrls, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $MaintenanceRecordCopyWith<$Res>  {
  factory $MaintenanceRecordCopyWith(MaintenanceRecord value, $Res Function(MaintenanceRecord) _then) = _$MaintenanceRecordCopyWithImpl;
@useResult
$Res call({
 String id, String vehicleId, String serviceType, String title, int? mileageAtService, double? cost, DateTime serviceDate, String? garageId, DateTime? nextServiceDate, int? nextServiceMileage, String? notes, List<String> photoUrls, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$MaintenanceRecordCopyWithImpl<$Res>
    implements $MaintenanceRecordCopyWith<$Res> {
  _$MaintenanceRecordCopyWithImpl(this._self, this._then);

  final MaintenanceRecord _self;
  final $Res Function(MaintenanceRecord) _then;

/// Create a copy of MaintenanceRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? vehicleId = null,Object? serviceType = null,Object? title = null,Object? mileageAtService = freezed,Object? cost = freezed,Object? serviceDate = null,Object? garageId = freezed,Object? nextServiceDate = freezed,Object? nextServiceMileage = freezed,Object? notes = freezed,Object? photoUrls = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,vehicleId: null == vehicleId ? _self.vehicleId : vehicleId // ignore: cast_nullable_to_non_nullable
as String,serviceType: null == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,mileageAtService: freezed == mileageAtService ? _self.mileageAtService : mileageAtService // ignore: cast_nullable_to_non_nullable
as int?,cost: freezed == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as double?,serviceDate: null == serviceDate ? _self.serviceDate : serviceDate // ignore: cast_nullable_to_non_nullable
as DateTime,garageId: freezed == garageId ? _self.garageId : garageId // ignore: cast_nullable_to_non_nullable
as String?,nextServiceDate: freezed == nextServiceDate ? _self.nextServiceDate : nextServiceDate // ignore: cast_nullable_to_non_nullable
as DateTime?,nextServiceMileage: freezed == nextServiceMileage ? _self.nextServiceMileage : nextServiceMileage // ignore: cast_nullable_to_non_nullable
as int?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,photoUrls: null == photoUrls ? _self.photoUrls : photoUrls // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MaintenanceRecord].
extension MaintenanceRecordPatterns on MaintenanceRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MaintenanceRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MaintenanceRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MaintenanceRecord value)  $default,){
final _that = this;
switch (_that) {
case _MaintenanceRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MaintenanceRecord value)?  $default,){
final _that = this;
switch (_that) {
case _MaintenanceRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String vehicleId,  String serviceType,  String title,  int? mileageAtService,  double? cost,  DateTime serviceDate,  String? garageId,  DateTime? nextServiceDate,  int? nextServiceMileage,  String? notes,  List<String> photoUrls,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MaintenanceRecord() when $default != null:
return $default(_that.id,_that.vehicleId,_that.serviceType,_that.title,_that.mileageAtService,_that.cost,_that.serviceDate,_that.garageId,_that.nextServiceDate,_that.nextServiceMileage,_that.notes,_that.photoUrls,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String vehicleId,  String serviceType,  String title,  int? mileageAtService,  double? cost,  DateTime serviceDate,  String? garageId,  DateTime? nextServiceDate,  int? nextServiceMileage,  String? notes,  List<String> photoUrls,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _MaintenanceRecord():
return $default(_that.id,_that.vehicleId,_that.serviceType,_that.title,_that.mileageAtService,_that.cost,_that.serviceDate,_that.garageId,_that.nextServiceDate,_that.nextServiceMileage,_that.notes,_that.photoUrls,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String vehicleId,  String serviceType,  String title,  int? mileageAtService,  double? cost,  DateTime serviceDate,  String? garageId,  DateTime? nextServiceDate,  int? nextServiceMileage,  String? notes,  List<String> photoUrls,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _MaintenanceRecord() when $default != null:
return $default(_that.id,_that.vehicleId,_that.serviceType,_that.title,_that.mileageAtService,_that.cost,_that.serviceDate,_that.garageId,_that.nextServiceDate,_that.nextServiceMileage,_that.notes,_that.photoUrls,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MaintenanceRecord implements MaintenanceRecord {
  const _MaintenanceRecord({required this.id, required this.vehicleId, required this.serviceType, required this.title, this.mileageAtService, this.cost, required this.serviceDate, this.garageId, this.nextServiceDate, this.nextServiceMileage, this.notes, final  List<String> photoUrls = const [], this.createdAt, this.updatedAt}): _photoUrls = photoUrls;
  factory _MaintenanceRecord.fromJson(Map<String, dynamic> json) => _$MaintenanceRecordFromJson(json);

@override final  String id;
@override final  String vehicleId;
@override final  String serviceType;
@override final  String title;
@override final  int? mileageAtService;
@override final  double? cost;
@override final  DateTime serviceDate;
@override final  String? garageId;
@override final  DateTime? nextServiceDate;
@override final  int? nextServiceMileage;
@override final  String? notes;
 final  List<String> _photoUrls;
@override@JsonKey() List<String> get photoUrls {
  if (_photoUrls is EqualUnmodifiableListView) return _photoUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photoUrls);
}

@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of MaintenanceRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MaintenanceRecordCopyWith<_MaintenanceRecord> get copyWith => __$MaintenanceRecordCopyWithImpl<_MaintenanceRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MaintenanceRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MaintenanceRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.vehicleId, vehicleId) || other.vehicleId == vehicleId)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.title, title) || other.title == title)&&(identical(other.mileageAtService, mileageAtService) || other.mileageAtService == mileageAtService)&&(identical(other.cost, cost) || other.cost == cost)&&(identical(other.serviceDate, serviceDate) || other.serviceDate == serviceDate)&&(identical(other.garageId, garageId) || other.garageId == garageId)&&(identical(other.nextServiceDate, nextServiceDate) || other.nextServiceDate == nextServiceDate)&&(identical(other.nextServiceMileage, nextServiceMileage) || other.nextServiceMileage == nextServiceMileage)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other._photoUrls, _photoUrls)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,vehicleId,serviceType,title,mileageAtService,cost,serviceDate,garageId,nextServiceDate,nextServiceMileage,notes,const DeepCollectionEquality().hash(_photoUrls),createdAt,updatedAt);

@override
String toString() {
  return 'MaintenanceRecord(id: $id, vehicleId: $vehicleId, serviceType: $serviceType, title: $title, mileageAtService: $mileageAtService, cost: $cost, serviceDate: $serviceDate, garageId: $garageId, nextServiceDate: $nextServiceDate, nextServiceMileage: $nextServiceMileage, notes: $notes, photoUrls: $photoUrls, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$MaintenanceRecordCopyWith<$Res> implements $MaintenanceRecordCopyWith<$Res> {
  factory _$MaintenanceRecordCopyWith(_MaintenanceRecord value, $Res Function(_MaintenanceRecord) _then) = __$MaintenanceRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String vehicleId, String serviceType, String title, int? mileageAtService, double? cost, DateTime serviceDate, String? garageId, DateTime? nextServiceDate, int? nextServiceMileage, String? notes, List<String> photoUrls, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$MaintenanceRecordCopyWithImpl<$Res>
    implements _$MaintenanceRecordCopyWith<$Res> {
  __$MaintenanceRecordCopyWithImpl(this._self, this._then);

  final _MaintenanceRecord _self;
  final $Res Function(_MaintenanceRecord) _then;

/// Create a copy of MaintenanceRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? vehicleId = null,Object? serviceType = null,Object? title = null,Object? mileageAtService = freezed,Object? cost = freezed,Object? serviceDate = null,Object? garageId = freezed,Object? nextServiceDate = freezed,Object? nextServiceMileage = freezed,Object? notes = freezed,Object? photoUrls = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_MaintenanceRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,vehicleId: null == vehicleId ? _self.vehicleId : vehicleId // ignore: cast_nullable_to_non_nullable
as String,serviceType: null == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,mileageAtService: freezed == mileageAtService ? _self.mileageAtService : mileageAtService // ignore: cast_nullable_to_non_nullable
as int?,cost: freezed == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as double?,serviceDate: null == serviceDate ? _self.serviceDate : serviceDate // ignore: cast_nullable_to_non_nullable
as DateTime,garageId: freezed == garageId ? _self.garageId : garageId // ignore: cast_nullable_to_non_nullable
as String?,nextServiceDate: freezed == nextServiceDate ? _self.nextServiceDate : nextServiceDate // ignore: cast_nullable_to_non_nullable
as DateTime?,nextServiceMileage: freezed == nextServiceMileage ? _self.nextServiceMileage : nextServiceMileage // ignore: cast_nullable_to_non_nullable
as int?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,photoUrls: null == photoUrls ? _self._photoUrls : photoUrls // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
