// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'garage.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Garage {

 String get id; String get name; String get address; String get city; double? get lat; double? get lng; String? get phone; List<String> get photoUrls; double get averageRating; int get totalReviews; bool get isVerified; Map<String, dynamic> get workingHours; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of Garage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GarageCopyWith<Garage> get copyWith => _$GarageCopyWithImpl<Garage>(this as Garage, _$identity);

  /// Serializes this Garage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Garage&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.city, city) || other.city == city)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.phone, phone) || other.phone == phone)&&const DeepCollectionEquality().equals(other.photoUrls, photoUrls)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.totalReviews, totalReviews) || other.totalReviews == totalReviews)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&const DeepCollectionEquality().equals(other.workingHours, workingHours)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,address,city,lat,lng,phone,const DeepCollectionEquality().hash(photoUrls),averageRating,totalReviews,isVerified,const DeepCollectionEquality().hash(workingHours),createdAt,updatedAt);

@override
String toString() {
  return 'Garage(id: $id, name: $name, address: $address, city: $city, lat: $lat, lng: $lng, phone: $phone, photoUrls: $photoUrls, averageRating: $averageRating, totalReviews: $totalReviews, isVerified: $isVerified, workingHours: $workingHours, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $GarageCopyWith<$Res>  {
  factory $GarageCopyWith(Garage value, $Res Function(Garage) _then) = _$GarageCopyWithImpl;
@useResult
$Res call({
 String id, String name, String address, String city, double? lat, double? lng, String? phone, List<String> photoUrls, double averageRating, int totalReviews, bool isVerified, Map<String, dynamic> workingHours, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$GarageCopyWithImpl<$Res>
    implements $GarageCopyWith<$Res> {
  _$GarageCopyWithImpl(this._self, this._then);

  final Garage _self;
  final $Res Function(Garage) _then;

/// Create a copy of Garage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? address = null,Object? city = null,Object? lat = freezed,Object? lng = freezed,Object? phone = freezed,Object? photoUrls = null,Object? averageRating = null,Object? totalReviews = null,Object? isVerified = null,Object? workingHours = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lng: freezed == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,photoUrls: null == photoUrls ? _self.photoUrls : photoUrls // ignore: cast_nullable_to_non_nullable
as List<String>,averageRating: null == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double,totalReviews: null == totalReviews ? _self.totalReviews : totalReviews // ignore: cast_nullable_to_non_nullable
as int,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,workingHours: null == workingHours ? _self.workingHours : workingHours // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Garage].
extension GaragePatterns on Garage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Garage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Garage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Garage value)  $default,){
final _that = this;
switch (_that) {
case _Garage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Garage value)?  $default,){
final _that = this;
switch (_that) {
case _Garage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String address,  String city,  double? lat,  double? lng,  String? phone,  List<String> photoUrls,  double averageRating,  int totalReviews,  bool isVerified,  Map<String, dynamic> workingHours,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Garage() when $default != null:
return $default(_that.id,_that.name,_that.address,_that.city,_that.lat,_that.lng,_that.phone,_that.photoUrls,_that.averageRating,_that.totalReviews,_that.isVerified,_that.workingHours,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String address,  String city,  double? lat,  double? lng,  String? phone,  List<String> photoUrls,  double averageRating,  int totalReviews,  bool isVerified,  Map<String, dynamic> workingHours,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Garage():
return $default(_that.id,_that.name,_that.address,_that.city,_that.lat,_that.lng,_that.phone,_that.photoUrls,_that.averageRating,_that.totalReviews,_that.isVerified,_that.workingHours,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String address,  String city,  double? lat,  double? lng,  String? phone,  List<String> photoUrls,  double averageRating,  int totalReviews,  bool isVerified,  Map<String, dynamic> workingHours,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Garage() when $default != null:
return $default(_that.id,_that.name,_that.address,_that.city,_that.lat,_that.lng,_that.phone,_that.photoUrls,_that.averageRating,_that.totalReviews,_that.isVerified,_that.workingHours,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Garage implements Garage {
  const _Garage({required this.id, required this.name, required this.address, required this.city, this.lat, this.lng, this.phone, final  List<String> photoUrls = const [], this.averageRating = 0.0, this.totalReviews = 0, this.isVerified = false, final  Map<String, dynamic> workingHours = const {}, this.createdAt, this.updatedAt}): _photoUrls = photoUrls,_workingHours = workingHours;
  factory _Garage.fromJson(Map<String, dynamic> json) => _$GarageFromJson(json);

@override final  String id;
@override final  String name;
@override final  String address;
@override final  String city;
@override final  double? lat;
@override final  double? lng;
@override final  String? phone;
 final  List<String> _photoUrls;
@override@JsonKey() List<String> get photoUrls {
  if (_photoUrls is EqualUnmodifiableListView) return _photoUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photoUrls);
}

@override@JsonKey() final  double averageRating;
@override@JsonKey() final  int totalReviews;
@override@JsonKey() final  bool isVerified;
 final  Map<String, dynamic> _workingHours;
@override@JsonKey() Map<String, dynamic> get workingHours {
  if (_workingHours is EqualUnmodifiableMapView) return _workingHours;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_workingHours);
}

@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of Garage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GarageCopyWith<_Garage> get copyWith => __$GarageCopyWithImpl<_Garage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GarageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Garage&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.city, city) || other.city == city)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.phone, phone) || other.phone == phone)&&const DeepCollectionEquality().equals(other._photoUrls, _photoUrls)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.totalReviews, totalReviews) || other.totalReviews == totalReviews)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&const DeepCollectionEquality().equals(other._workingHours, _workingHours)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,address,city,lat,lng,phone,const DeepCollectionEquality().hash(_photoUrls),averageRating,totalReviews,isVerified,const DeepCollectionEquality().hash(_workingHours),createdAt,updatedAt);

@override
String toString() {
  return 'Garage(id: $id, name: $name, address: $address, city: $city, lat: $lat, lng: $lng, phone: $phone, photoUrls: $photoUrls, averageRating: $averageRating, totalReviews: $totalReviews, isVerified: $isVerified, workingHours: $workingHours, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$GarageCopyWith<$Res> implements $GarageCopyWith<$Res> {
  factory _$GarageCopyWith(_Garage value, $Res Function(_Garage) _then) = __$GarageCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String address, String city, double? lat, double? lng, String? phone, List<String> photoUrls, double averageRating, int totalReviews, bool isVerified, Map<String, dynamic> workingHours, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$GarageCopyWithImpl<$Res>
    implements _$GarageCopyWith<$Res> {
  __$GarageCopyWithImpl(this._self, this._then);

  final _Garage _self;
  final $Res Function(_Garage) _then;

/// Create a copy of Garage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? address = null,Object? city = null,Object? lat = freezed,Object? lng = freezed,Object? phone = freezed,Object? photoUrls = null,Object? averageRating = null,Object? totalReviews = null,Object? isVerified = null,Object? workingHours = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_Garage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lng: freezed == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,photoUrls: null == photoUrls ? _self._photoUrls : photoUrls // ignore: cast_nullable_to_non_nullable
as List<String>,averageRating: null == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double,totalReviews: null == totalReviews ? _self.totalReviews : totalReviews // ignore: cast_nullable_to_non_nullable
as int,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,workingHours: null == workingHours ? _self._workingHours : workingHours // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
