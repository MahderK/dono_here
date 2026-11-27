// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'donor_profile_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DonorProfileFormState {

 BloodType? get bloodType; String get area; DateTime? get lastDonation; bool get isAvailable; bool get isVisible; bool get isSaving; String? get bloodTypeError; String? get areaError; String? get saveError;
/// Create a copy of DonorProfileFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DonorProfileFormStateCopyWith<DonorProfileFormState> get copyWith => _$DonorProfileFormStateCopyWithImpl<DonorProfileFormState>(this as DonorProfileFormState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DonorProfileFormState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DonorProfileFormState&&(identical(other.bloodType, _this.bloodType) || other.bloodType == _this.bloodType)&&(identical(other.area, _this.area) || other.area == _this.area)&&(identical(other.lastDonation, _this.lastDonation) || other.lastDonation == _this.lastDonation)&&(identical(other.isAvailable, _this.isAvailable) || other.isAvailable == _this.isAvailable)&&(identical(other.isVisible, _this.isVisible) || other.isVisible == _this.isVisible)&&(identical(other.isSaving, _this.isSaving) || other.isSaving == _this.isSaving)&&(identical(other.bloodTypeError, _this.bloodTypeError) || other.bloodTypeError == _this.bloodTypeError)&&(identical(other.areaError, _this.areaError) || other.areaError == _this.areaError)&&(identical(other.saveError, _this.saveError) || other.saveError == _this.saveError));
}


@override
int get hashCode {
  final _this = this as DonorProfileFormState;
  return Object.hash(runtimeType,_this.bloodType,_this.area,_this.lastDonation,_this.isAvailable,_this.isVisible,_this.isSaving,_this.bloodTypeError,_this.areaError,_this.saveError);
}

@override
String toString() {
  final _this = this as DonorProfileFormState;
  return 'DonorProfileFormState(bloodType: ${_this.bloodType}, area: ${_this.area}, lastDonation: ${_this.lastDonation}, isAvailable: ${_this.isAvailable}, isVisible: ${_this.isVisible}, isSaving: ${_this.isSaving}, bloodTypeError: ${_this.bloodTypeError}, areaError: ${_this.areaError}, saveError: ${_this.saveError})';
}


}

/// @nodoc
abstract mixin class $DonorProfileFormStateCopyWith<$Res>  {
  factory $DonorProfileFormStateCopyWith(DonorProfileFormState value, $Res Function(DonorProfileFormState) _then) = _$DonorProfileFormStateCopyWithImpl;
@useResult
$Res call({
 BloodType? bloodType, String area, DateTime? lastDonation, bool isAvailable, bool isVisible, bool isSaving, String? bloodTypeError, String? areaError, String? saveError
});




}
/// @nodoc
class _$DonorProfileFormStateCopyWithImpl<$Res>
    implements $DonorProfileFormStateCopyWith<$Res> {
  _$DonorProfileFormStateCopyWithImpl(this._self, this._then);

  final DonorProfileFormState _self;
  final $Res Function(DonorProfileFormState) _then;

/// Create a copy of DonorProfileFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bloodType = freezed,Object? area = null,Object? lastDonation = freezed,Object? isAvailable = null,Object? isVisible = null,Object? isSaving = null,Object? bloodTypeError = freezed,Object? areaError = freezed,Object? saveError = freezed,}) {
  return _then(DonorProfileFormState(
bloodType: freezed == bloodType ? _self.bloodType : bloodType // ignore: cast_nullable_to_non_nullable
as BloodType?,area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String,lastDonation: freezed == lastDonation ? _self.lastDonation : lastDonation // ignore: cast_nullable_to_non_nullable
as DateTime?,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,isVisible: null == isVisible ? _self.isVisible : isVisible // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,bloodTypeError: freezed == bloodTypeError ? _self.bloodTypeError : bloodTypeError // ignore: cast_nullable_to_non_nullable
as String?,areaError: freezed == areaError ? _self.areaError : areaError // ignore: cast_nullable_to_non_nullable
as String?,saveError: freezed == saveError ? _self.saveError : saveError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DonorProfileFormState].
extension DonorProfileFormStatePatterns on DonorProfileFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DonorProfileFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DonorProfileFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DonorProfileFormState value)  $default,){
final _that = this;
switch (_that) {
case _DonorProfileFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DonorProfileFormState value)?  $default,){
final _that = this;
switch (_that) {
case _DonorProfileFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BloodType? bloodType,  String area,  DateTime? lastDonation,  bool isAvailable,  bool isVisible,  bool isSaving,  String? bloodTypeError,  String? areaError,  String? saveError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DonorProfileFormState() when $default != null:
return $default(_that.bloodType,_that.area,_that.lastDonation,_that.isAvailable,_that.isVisible,_that.isSaving,_that.bloodTypeError,_that.areaError,_that.saveError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BloodType? bloodType,  String area,  DateTime? lastDonation,  bool isAvailable,  bool isVisible,  bool isSaving,  String? bloodTypeError,  String? areaError,  String? saveError)  $default,) {final _that = this;
switch (_that) {
case _DonorProfileFormState():
return $default(_that.bloodType,_that.area,_that.lastDonation,_that.isAvailable,_that.isVisible,_that.isSaving,_that.bloodTypeError,_that.areaError,_that.saveError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BloodType? bloodType,  String area,  DateTime? lastDonation,  bool isAvailable,  bool isVisible,  bool isSaving,  String? bloodTypeError,  String? areaError,  String? saveError)?  $default,) {final _that = this;
switch (_that) {
case _DonorProfileFormState() when $default != null:
return $default(_that.bloodType,_that.area,_that.lastDonation,_that.isAvailable,_that.isVisible,_that.isSaving,_that.bloodTypeError,_that.areaError,_that.saveError);case _:
  return null;

}
}

}

/// @nodoc


class _DonorProfileFormState implements DonorProfileFormState {
  const _DonorProfileFormState({this.bloodType, this.area = '', this.lastDonation, this.isAvailable = true, this.isVisible = true, this.isSaving = false, this.bloodTypeError, this.areaError, this.saveError});
  

@override final  BloodType? bloodType;
@override@JsonKey() final  String area;
@override final  DateTime? lastDonation;
@override@JsonKey() final  bool isAvailable;
@override@JsonKey() final  bool isVisible;
@override@JsonKey() final  bool isSaving;
@override final  String? bloodTypeError;
@override final  String? areaError;
@override final  String? saveError;

/// Create a copy of DonorProfileFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DonorProfileFormStateCopyWith<_DonorProfileFormState> get copyWith => __$DonorProfileFormStateCopyWithImpl<_DonorProfileFormState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DonorProfileFormState&&(identical(other.bloodType, bloodType) || other.bloodType == bloodType)&&(identical(other.area, area) || other.area == area)&&(identical(other.lastDonation, lastDonation) || other.lastDonation == lastDonation)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&(identical(other.isVisible, isVisible) || other.isVisible == isVisible)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.bloodTypeError, bloodTypeError) || other.bloodTypeError == bloodTypeError)&&(identical(other.areaError, areaError) || other.areaError == areaError)&&(identical(other.saveError, saveError) || other.saveError == saveError));
}


@override
int get hashCode {
    return Object.hash(runtimeType,bloodType,area,lastDonation,isAvailable,isVisible,isSaving,bloodTypeError,areaError,saveError);
}

@override
String toString() {
    return 'DonorProfileFormState(bloodType: $bloodType, area: $area, lastDonation: $lastDonation, isAvailable: $isAvailable, isVisible: $isVisible, isSaving: $isSaving, bloodTypeError: $bloodTypeError, areaError: $areaError, saveError: $saveError)';
}


}

/// @nodoc
abstract mixin class _$DonorProfileFormStateCopyWith<$Res> implements $DonorProfileFormStateCopyWith<$Res> {
  factory _$DonorProfileFormStateCopyWith(_DonorProfileFormState value, $Res Function(_DonorProfileFormState) _then) = __$DonorProfileFormStateCopyWithImpl;
@override @useResult
$Res call({
 BloodType? bloodType, String area, DateTime? lastDonation, bool isAvailable, bool isVisible, bool isSaving, String? bloodTypeError, String? areaError, String? saveError
});




}
/// @nodoc
class __$DonorProfileFormStateCopyWithImpl<$Res>
    implements _$DonorProfileFormStateCopyWith<$Res> {
  __$DonorProfileFormStateCopyWithImpl(this._self, this._then);

  final _DonorProfileFormState _self;
  final $Res Function(_DonorProfileFormState) _then;

/// Create a copy of DonorProfileFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bloodType = freezed,Object? area = null,Object? lastDonation = freezed,Object? isAvailable = null,Object? isVisible = null,Object? isSaving = null,Object? bloodTypeError = freezed,Object? areaError = freezed,Object? saveError = freezed,}) {
  return _then(_DonorProfileFormState(
bloodType: freezed == bloodType ? _self.bloodType : bloodType // ignore: cast_nullable_to_non_nullable
as BloodType?,area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String,lastDonation: freezed == lastDonation ? _self.lastDonation : lastDonation // ignore: cast_nullable_to_non_nullable
as DateTime?,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,isVisible: null == isVisible ? _self.isVisible : isVisible // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,bloodTypeError: freezed == bloodTypeError ? _self.bloodTypeError : bloodTypeError // ignore: cast_nullable_to_non_nullable
as String?,areaError: freezed == areaError ? _self.areaError : areaError // ignore: cast_nullable_to_non_nullable
as String?,saveError: freezed == saveError ? _self.saveError : saveError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
