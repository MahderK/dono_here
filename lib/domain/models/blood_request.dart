import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'blood_request.freezed.dart';

@freezed
abstract class BloodRequest with _$BloodRequest {
  const factory BloodRequest({
    required String id,
    required String requesterId,
    required String hospital,
    @Default('') String area,
    required BloodType bloodTypeNeeded,
    required int unitsNeeded,
    required double latitude,
    required double longitude,
    required RequestUrgency urgency,
    required RequestStatus status,
    required DateTime createdAt,
  }) = _BloodRequest;
}
