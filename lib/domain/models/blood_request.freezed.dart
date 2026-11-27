// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'blood_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BloodRequest {

 String get id; String get requesterId; String get hospital; String get area; BloodType get bloodTypeNeeded; int get unitsNeeded; double get latitude; double get longitude; RequestUrgency get urgency; RequestStatus get status; DateTime get createdAt;
/// Create a copy of BloodRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BloodRequestCopyWith<BloodRequest> get copyWith => _$BloodRequestCopyWithImpl<BloodRequest>(this as BloodRequest, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BloodRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BloodRequest&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.requesterId, _this.requesterId) || other.requesterId == _this.requesterId)&&(identical(other.hospital, _this.hospital) || other.hospital == _this.hospital)&&(identical(other.area, _this.area) || other.area == _this.area)&&(identical(other.bloodTypeNeeded, _this.bloodTypeNeeded) || other.bloodTypeNeeded == _this.bloodTypeNeeded)&&(identical(other.unitsNeeded, _this.unitsNeeded) || other.unitsNeeded == _this.unitsNeeded)&&(identical(other.latitude, _this.latitude) || other.latitude == _this.latitude)&&(identical(other.longitude, _this.longitude) || other.longitude == _this.longitude)&&(identical(other.urgency, _this.urgency) || other.urgency == _this.urgency)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}


@override
int get hashCode {
  final _this = this as BloodRequest;
  return Object.hash(runtimeType,_this.id,_this.requesterId,_this.hospital,_this.area,_this.bloodTypeNeeded,_this.unitsNeeded,_this.latitude,_this.longitude,_this.urgency,_this.status,_this.createdAt);
}

@override
String toString() {
  final _this = this as BloodRequest;
  return 'BloodRequest(id: ${_this.id}, requesterId: ${_this.requesterId}, hospital: ${_this.hospital}, area: ${_this.area}, bloodTypeNeeded: ${_this.bloodTypeNeeded}, unitsNeeded: ${_this.unitsNeeded}, latitude: ${_this.latitude}, longitude: ${_this.longitude}, urgency: ${_this.urgency}, status: ${_this.status}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $BloodRequestCopyWith<$Res>  {
  factory $BloodRequestCopyWith(BloodRequest value, $Res Function(BloodRequest) _then) = _$BloodRequestCopyWithImpl;
@useResult
$Res call({
 String id, String requesterId, String hospital, String area, BloodType bloodTypeNeeded, int unitsNeeded, double latitude, double longitude, RequestUrgency urgency, RequestStatus status, DateTime createdAt
});




}
/// @nodoc
class _$BloodRequestCopyWithImpl<$Res>
    implements $BloodRequestCopyWith<$Res> {
  _$BloodRequestCopyWithImpl(this._self, this._then);

  final BloodRequest _self;
  final $Res Function(BloodRequest) _then;

/// Create a copy of BloodRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? requesterId = null,Object? hospital = null,Object? area = null,Object? bloodTypeNeeded = null,Object? unitsNeeded = null,Object? latitude = null,Object? longitude = null,Object? urgency = null,Object? status = null,Object? createdAt = null,}) {
  return _then(BloodRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,requesterId: null == requesterId ? _self.requesterId : requesterId // ignore: cast_nullable_to_non_nullable
as String,hospital: null == hospital ? _self.hospital : hospital // ignore: cast_nullable_to_non_nullable
as String,area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String,bloodTypeNeeded: null == bloodTypeNeeded ? _self.bloodTypeNeeded : bloodTypeNeeded // ignore: cast_nullable_to_non_nullable
as BloodType,unitsNeeded: null == unitsNeeded ? _self.unitsNeeded : unitsNeeded // ignore: cast_nullable_to_non_nullable
as int,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,urgency: null == urgency ? _self.urgency : urgency // ignore: cast_nullable_to_non_nullable
as RequestUrgency,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [BloodRequest].
extension BloodRequestPatterns on BloodRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BloodRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BloodRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BloodRequest value)  $default,){
final _that = this;
switch (_that) {
case _BloodRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BloodRequest value)?  $default,){
final _that = this;
switch (_that) {
case _BloodRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String requesterId,  String hospital,  String area,  BloodType bloodTypeNeeded,  int unitsNeeded,  double latitude,  double longitude,  RequestUrgency urgency,  RequestStatus status,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BloodRequest() when $default != null:
return $default(_that.id,_that.requesterId,_that.hospital,_that.area,_that.bloodTypeNeeded,_that.unitsNeeded,_that.latitude,_that.longitude,_that.urgency,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String requesterId,  String hospital,  String area,  BloodType bloodTypeNeeded,  int unitsNeeded,  double latitude,  double longitude,  RequestUrgency urgency,  RequestStatus status,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _BloodRequest():
return $default(_that.id,_that.requesterId,_that.hospital,_that.area,_that.bloodTypeNeeded,_that.unitsNeeded,_that.latitude,_that.longitude,_that.urgency,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String requesterId,  String hospital,  String area,  BloodType bloodTypeNeeded,  int unitsNeeded,  double latitude,  double longitude,  RequestUrgency urgency,  RequestStatus status,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _BloodRequest() when $default != null:
return $default(_that.id,_that.requesterId,_that.hospital,_that.area,_that.bloodTypeNeeded,_that.unitsNeeded,_that.latitude,_that.longitude,_that.urgency,_that.status,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _BloodRequest implements BloodRequest {
  const _BloodRequest({required this.id, required this.requesterId, required this.hospital, this.area = '', required this.bloodTypeNeeded, required this.unitsNeeded, required this.latitude, required this.longitude, required this.urgency, required this.status, required this.createdAt});
  

@override final  String id;
@override final  String requesterId;
@override final  String hospital;
@override@JsonKey() final  String area;
@override final  BloodType bloodTypeNeeded;
@override final  int unitsNeeded;
@override final  double latitude;
@override final  double longitude;
@override final  RequestUrgency urgency;
@override final  RequestStatus status;
@override final  DateTime createdAt;

/// Create a copy of BloodRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BloodRequestCopyWith<_BloodRequest> get copyWith => __$BloodRequestCopyWithImpl<_BloodRequest>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BloodRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.requesterId, requesterId) || other.requesterId == requesterId)&&(identical(other.hospital, hospital) || other.hospital == hospital)&&(identical(other.area, area) || other.area == area)&&(identical(other.bloodTypeNeeded, bloodTypeNeeded) || other.bloodTypeNeeded == bloodTypeNeeded)&&(identical(other.unitsNeeded, unitsNeeded) || other.unitsNeeded == unitsNeeded)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.urgency, urgency) || other.urgency == urgency)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,requesterId,hospital,area,bloodTypeNeeded,unitsNeeded,latitude,longitude,urgency,status,createdAt);
}

@override
String toString() {
    return 'BloodRequest(id: $id, requesterId: $requesterId, hospital: $hospital, area: $area, bloodTypeNeeded: $bloodTypeNeeded, unitsNeeded: $unitsNeeded, latitude: $latitude, longitude: $longitude, urgency: $urgency, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$BloodRequestCopyWith<$Res> implements $BloodRequestCopyWith<$Res> {
  factory _$BloodRequestCopyWith(_BloodRequest value, $Res Function(_BloodRequest) _then) = __$BloodRequestCopyWithImpl;
@override @useResult
$Res call({
 String id, String requesterId, String hospital, String area, BloodType bloodTypeNeeded, int unitsNeeded, double latitude, double longitude, RequestUrgency urgency, RequestStatus status, DateTime createdAt
});




}
/// @nodoc
class __$BloodRequestCopyWithImpl<$Res>
    implements _$BloodRequestCopyWith<$Res> {
  __$BloodRequestCopyWithImpl(this._self, this._then);

  final _BloodRequest _self;
  final $Res Function(_BloodRequest) _then;

/// Create a copy of BloodRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? requesterId = null,Object? hospital = null,Object? area = null,Object? bloodTypeNeeded = null,Object? unitsNeeded = null,Object? latitude = null,Object? longitude = null,Object? urgency = null,Object? status = null,Object? createdAt = null,}) {
  return _then(_BloodRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,requesterId: null == requesterId ? _self.requesterId : requesterId // ignore: cast_nullable_to_non_nullable
as String,hospital: null == hospital ? _self.hospital : hospital // ignore: cast_nullable_to_non_nullable
as String,area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String,bloodTypeNeeded: null == bloodTypeNeeded ? _self.bloodTypeNeeded : bloodTypeNeeded // ignore: cast_nullable_to_non_nullable
as BloodType,unitsNeeded: null == unitsNeeded ? _self.unitsNeeded : unitsNeeded // ignore: cast_nullable_to_non_nullable
as int,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,urgency: null == urgency ? _self.urgency : urgency // ignore: cast_nullable_to_non_nullable
as RequestUrgency,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
