// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RequestResponse {

 String get id; String get requestId; String get donorId; ResponseStatus get status; DateTime get createdAt;
/// Create a copy of RequestResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestResponseCopyWith<RequestResponse> get copyWith => _$RequestResponseCopyWithImpl<RequestResponse>(this as RequestResponse, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RequestResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestResponse&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.requestId, _this.requestId) || other.requestId == _this.requestId)&&(identical(other.donorId, _this.donorId) || other.donorId == _this.donorId)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}


@override
int get hashCode {
  final _this = this as RequestResponse;
  return Object.hash(runtimeType,_this.id,_this.requestId,_this.donorId,_this.status,_this.createdAt);
}

@override
String toString() {
  final _this = this as RequestResponse;
  return 'RequestResponse(id: ${_this.id}, requestId: ${_this.requestId}, donorId: ${_this.donorId}, status: ${_this.status}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $RequestResponseCopyWith<$Res>  {
  factory $RequestResponseCopyWith(RequestResponse value, $Res Function(RequestResponse) _then) = _$RequestResponseCopyWithImpl;
@useResult
$Res call({
 String id, String requestId, String donorId, ResponseStatus status, DateTime createdAt
});




}
/// @nodoc
class _$RequestResponseCopyWithImpl<$Res>
    implements $RequestResponseCopyWith<$Res> {
  _$RequestResponseCopyWithImpl(this._self, this._then);

  final RequestResponse _self;
  final $Res Function(RequestResponse) _then;

/// Create a copy of RequestResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? requestId = null,Object? donorId = null,Object? status = null,Object? createdAt = null,}) {
  return _then(RequestResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,donorId: null == donorId ? _self.donorId : donorId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ResponseStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [RequestResponse].
extension RequestResponsePatterns on RequestResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RequestResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RequestResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RequestResponse value)  $default,){
final _that = this;
switch (_that) {
case _RequestResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RequestResponse value)?  $default,){
final _that = this;
switch (_that) {
case _RequestResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String requestId,  String donorId,  ResponseStatus status,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RequestResponse() when $default != null:
return $default(_that.id,_that.requestId,_that.donorId,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String requestId,  String donorId,  ResponseStatus status,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _RequestResponse():
return $default(_that.id,_that.requestId,_that.donorId,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String requestId,  String donorId,  ResponseStatus status,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _RequestResponse() when $default != null:
return $default(_that.id,_that.requestId,_that.donorId,_that.status,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _RequestResponse implements RequestResponse {
  const _RequestResponse({required this.id, required this.requestId, required this.donorId, required this.status, required this.createdAt});
  

@override final  String id;
@override final  String requestId;
@override final  String donorId;
@override final  ResponseStatus status;
@override final  DateTime createdAt;

/// Create a copy of RequestResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestResponseCopyWith<_RequestResponse> get copyWith => __$RequestResponseCopyWithImpl<_RequestResponse>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.donorId, donorId) || other.donorId == donorId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,requestId,donorId,status,createdAt);
}

@override
String toString() {
    return 'RequestResponse(id: $id, requestId: $requestId, donorId: $donorId, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$RequestResponseCopyWith<$Res> implements $RequestResponseCopyWith<$Res> {
  factory _$RequestResponseCopyWith(_RequestResponse value, $Res Function(_RequestResponse) _then) = __$RequestResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String requestId, String donorId, ResponseStatus status, DateTime createdAt
});




}
/// @nodoc
class __$RequestResponseCopyWithImpl<$Res>
    implements _$RequestResponseCopyWith<$Res> {
  __$RequestResponseCopyWithImpl(this._self, this._then);

  final _RequestResponse _self;
  final $Res Function(_RequestResponse) _then;

/// Create a copy of RequestResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? requestId = null,Object? donorId = null,Object? status = null,Object? createdAt = null,}) {
  return _then(_RequestResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,donorId: null == donorId ? _self.donorId : donorId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ResponseStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
