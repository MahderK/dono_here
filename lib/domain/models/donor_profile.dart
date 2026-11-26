import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'donor_profile.freezed.dart';

@freezed
abstract class DonorProfile with _$DonorProfile {
  const factory DonorProfile({
    required String id,
    required String userId,
    required String area,
    required BloodType bloodType,
    DateTime? lastDonation,
    required double latitude,
    required double longitude,
    required bool isAvailable,
    required bool isVisible,
    required DateTime updatedAt,
  }) = _DonorProfile;
}
