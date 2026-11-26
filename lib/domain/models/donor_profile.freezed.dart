// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'donor_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DonorProfile {

 String get id; String get userId; String get area; BloodType get bloodType; DateTime? get lastDonation; double get latitude; double get longitude; bool get isAvailable; bool get isVisible; DateTime get updatedAt;
/// Create a copy of DonorProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DonorProfileCopyWith<DonorProfile> get copyWith => _$DonorProfileCopyWithImpl<DonorProfile>(this as DonorProfile, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DonorProfile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DonorProfile&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.area, _this.area) || other.area == _this.area)&&(identical(other.bloodType, _this.bloodType) || other.bloodType == _this.bloodType)&&(identical(other.lastDonation, _this.lastDonation) || other.lastDonation == _this.lastDonation)&&(identical(other.latitude, _this.latitude) || other.latitude == _this.latitude)&&(identical(other.longitude, _this.longitude) || other.longitude == _this.longitude)&&(identical(other.isAvailable, _this.isAvailable) || other.isAvailable == _this.isAvailable)&&(identical(other.isVisible, _this.isVisible) || other.isVisible == _this.isVisible)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}


@override
int get hashCode {
  final _this = this as DonorProfile;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.area,_this.bloodType,_this.lastDonation,_this.latitude,_this.longitude,_this.isAvailable,_this.isVisible,_this.updatedAt);
}

@override
String toString() {
  final _this = this as DonorProfile;
  return 'DonorProfile(id: ${_this.id}, userId: ${_this.userId}, area: ${_this.area}, bloodType: ${_this.bloodType}, lastDonation: ${_this.lastDonation}, latitude: ${_this.latitude}, longitude: ${_this.longitude}, isAvailable: ${_this.isAvailable}, isVisible: ${_this.isVisible}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $DonorProfileCopyWith<$Res>  {
  factory $DonorProfileCopyWith(DonorProfile value, $Res Function(DonorProfile) _then) = _$DonorProfileCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String area, BloodType bloodType, DateTime? lastDonation, double latitude, double longitude, bool isAvailable, bool isVisible, DateTime updatedAt
});




}
/// @nodoc
class _$DonorProfileCopyWithImpl<$Res>
    implements $DonorProfileCopyWith<$Res> {
  _$DonorProfileCopyWithImpl(this._self, this._then);

  final DonorProfile _self;
  final $Res Function(DonorProfile) _then;

/// Create a copy of DonorProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? area = null,Object? bloodType = null,Object? lastDonation = freezed,Object? latitude = null,Object? longitude = null,Object? isAvailable = null,Object? isVisible = null,Object? updatedAt = null,}) {
  return _then(DonorProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String,bloodType: null == bloodType ? _self.bloodType : bloodType // ignore: cast_nullable_to_non_nullable
as BloodType,lastDonation: freezed == lastDonation ? _self.lastDonation : lastDonation // ignore: cast_nullable_to_non_nullable
as DateTime?,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,isVisible: null == isVisible ? _self.isVisible : isVisible // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [DonorProfile].
extension DonorProfilePatterns on DonorProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DonorProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DonorProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DonorProfile value)  $default,){
final _that = this;
switch (_that) {
case _DonorProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DonorProfile value)?  $default,){
final _that = this;
switch (_that) {
case _DonorProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String area,  BloodType bloodType,  DateTime? lastDonation,  double latitude,  double longitude,  bool isAvailable,  bool isVisible,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DonorProfile() when $default != null:
return $default(_that.id,_that.userId,_that.area,_that.bloodType,_that.lastDonation,_that.latitude,_that.longitude,_that.isAvailable,_that.isVisible,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String area,  BloodType bloodType,  DateTime? lastDonation,  double latitude,  double longitude,  bool isAvailable,  bool isVisible,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _DonorProfile():
return $default(_that.id,_that.userId,_that.area,_that.bloodType,_that.lastDonation,_that.latitude,_that.longitude,_that.isAvailable,_that.isVisible,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String area,  BloodType bloodType,  DateTime? lastDonation,  double latitude,  double longitude,  bool isAvailable,  bool isVisible,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _DonorProfile() when $default != null:
return $default(_that.id,_that.userId,_that.area,_that.bloodType,_that.lastDonation,_that.latitude,_that.longitude,_that.isAvailable,_that.isVisible,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _DonorProfile implements DonorProfile {
  const _DonorProfile({required this.id, required this.userId, required this.area, required this.bloodType, this.lastDonation, required this.latitude, required this.longitude, required this.isAvailable, required this.isVisible, required this.updatedAt});
  

@override final  String id;
@override final  String userId;
@override final  String area;
@override final  BloodType bloodType;
@override final  DateTime? lastDonation;
@override final  double latitude;
@override final  double longitude;
@override final  bool isAvailable;
@override final  bool isVisible;
@override final  DateTime updatedAt;

/// Create a copy of DonorProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DonorProfileCopyWith<_DonorProfile> get copyWith => __$DonorProfileCopyWithImpl<_DonorProfile>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DonorProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.area, area) || other.area == area)&&(identical(other.bloodType, bloodType) || other.bloodType == bloodType)&&(identical(other.lastDonation, lastDonation) || other.lastDonation == lastDonation)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&(identical(other.isVisible, isVisible) || other.isVisible == isVisible)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,area,bloodType,lastDonation,latitude,longitude,isAvailable,isVisible,updatedAt);
}

@override
String toString() {
    return 'DonorProfile(id: $id, userId: $userId, area: $area, bloodType: $bloodType, lastDonation: $lastDonation, latitude: $latitude, longitude: $longitude, isAvailable: $isAvailable, isVisible: $isVisible, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$DonorProfileCopyWith<$Res> implements $DonorProfileCopyWith<$Res> {
  factory _$DonorProfileCopyWith(_DonorProfile value, $Res Function(_DonorProfile) _then) = __$DonorProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String area, BloodType bloodType, DateTime? lastDonation, double latitude, double longitude, bool isAvailable, bool isVisible, DateTime updatedAt
});




}
/// @nodoc
class __$DonorProfileCopyWithImpl<$Res>
    implements _$DonorProfileCopyWith<$Res> {
  __$DonorProfileCopyWithImpl(this._self, this._then);

  final _DonorProfile _self;
  final $Res Function(_DonorProfile) _then;

/// Create a copy of DonorProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? area = null,Object? bloodType = null,Object? lastDonation = freezed,Object? latitude = null,Object? longitude = null,Object? isAvailable = null,Object? isVisible = null,Object? updatedAt = null,}) {
  return _then(_DonorProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String,bloodType: null == bloodType ? _self.bloodType : bloodType // ignore: cast_nullable_to_non_nullable
as BloodType,lastDonation: freezed == lastDonation ? _self.lastDonation : lastDonation // ignore: cast_nullable_to_non_nullable
as DateTime?,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,isVisible: null == isVisible ? _self.isVisible : isVisible // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
