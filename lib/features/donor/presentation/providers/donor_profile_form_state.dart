import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/models/enums.dart';

part 'donor_profile_form_state.freezed.dart';

/// The draft values of the donor profile form plus validation / saving state.
@freezed
abstract class DonorProfileFormState with _$DonorProfileFormState {
  const factory DonorProfileFormState({
    BloodType? bloodType,
    @Default('') String area,
    DateTime? lastDonation,
    @Default(true) bool isAvailable,
    @Default(true) bool isVisible,
    @Default(false) bool isSaving,
    String? bloodTypeError,
    String? areaError,
    String? saveError,
  }) = _DonorProfileFormState;
}
