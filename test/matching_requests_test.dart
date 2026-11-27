import 'package:dono_here/domain/models/blood_request.dart';
import 'package:dono_here/domain/models/donor_profile.dart';
import 'package:dono_here/domain/models/enums.dart';
import 'package:dono_here/features/donor/presentation/providers/matching_requests_providers.dart';
import 'package:flutter_test/flutter_test.dart';

BloodRequest _request({
  required String id,
  String requesterId = 'user-1',
  BloodType bloodType = BloodType.oPositive,
  RequestUrgency urgency = RequestUrgency.medium,
  RequestStatus status = RequestStatus.open,
  DateTime? createdAt,
}) => BloodRequest(
  id: id,
  requesterId: requesterId,
  hospital: 'Test Hospital',
  bloodTypeNeeded: bloodType,
  unitsNeeded: 1,
  latitude: 9.0,
  longitude: 38.7,
  urgency: urgency,
  status: status,
  createdAt: createdAt ?? DateTime.utc(2026, 1, 1),
);

final _donor = DonorProfile(
  id: 'donor-x',
  userId: 'user-9',
  area: 'Bole',
  bloodType: BloodType.oPositive,
  latitude: 9.0,
  longitude: 38.7,
  isAvailable: true,
  isVisible: true,
  updatedAt: DateTime.utc(2026, 1, 1),
);

void main() {
  group('filterRequestsForDonor', () {
    test('keeps only open requests that need the donor blood type', () {
      final result = filterRequestsForDonor(
        requests: [
          _request(id: 'match'),
          _request(id: 'wrong-type', bloodType: BloodType.aPositive),
          _request(id: 'fulfilled', status: RequestStatus.fulfilled),
        ],
        profile: _donor,
        currentUserId: 'user-9',
      );
      expect(result.map((r) => r.id), ['match']);
    });

    test('hides the donor own requests', () {
      final result = filterRequestsForDonor(
        requests: [
          _request(id: 'mine', requesterId: 'user-9'),
          _request(id: 'theirs'),
        ],
        profile: _donor,
        currentUserId: 'user-9',
      );
      expect(result.map((r) => r.id), ['theirs']);
    });

    test('puts critical first, then the newest', () {
      final result = filterRequestsForDonor(
        requests: [
          _request(id: 'old-medium', createdAt: DateTime.utc(2026, 1, 1)),
          _request(id: 'new-medium', createdAt: DateTime.utc(2026, 1, 5)),
          _request(id: 'critical', urgency: RequestUrgency.critical),
        ],
        profile: _donor,
        currentUserId: 'user-9',
      );
      expect(result.map((r) => r.id), ['critical', 'new-medium', 'old-medium']);
    });
  });
}
