import 'package:dono_here/core/providers/repository_providers.dart';
import 'package:dono_here/data/seed/seed_data.dart';
import 'package:dono_here/domain/models/blood_request.dart';
import 'package:dono_here/domain/models/donor_profile.dart';
import 'package:dono_here/domain/models/enums.dart';
import 'package:dono_here/features/auth/presentation/providers/current_user_provider.dart';
import 'package:dono_here/features/donor/presentation/providers/respond_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

BloodRequest _request({
  String requesterId = 'user-1',
  BloodType bloodType = BloodType.oPositive,
  RequestStatus status = RequestStatus.open,
}) => BloodRequest(
  id: 'request-t',
  requesterId: requesterId,
  hospital: 'Test Hospital',
  bloodTypeNeeded: bloodType,
  unitsNeeded: 1,
  latitude: 9.0,
  longitude: 38.7,
  urgency: RequestUrgency.medium,
  status: status,
  createdAt: DateTime.utc(2026, 1, 1),
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

RespondEligibility _check({
  BloodRequest? request,
  String? userId = 'user-9',
  DonorProfile? profile,
  bool alreadyResponded = false,
}) => checkRespondEligibility(
  request: request ?? _request(),
  userId: userId,
  profile: profile,
  alreadyResponded: alreadyResponded,
);

void main() {
  group('checkRespondEligibility', () {
    test('can respond when open, available and blood type matches', () {
      expect(_check(profile: _donor), RespondEligibility.canRespond);
    });

    test('signed out users cannot respond', () {
      expect(
        _check(userId: null, profile: _donor),
        RespondEligibility.signedOut,
      );
    });

    test('the requester cannot respond to their own request', () {
      expect(
        _check(request: _request(requesterId: 'user-9'), profile: _donor),
        RespondEligibility.ownRequest,
      );
    });

    test('a user without a donor profile is asked to complete it', () {
      expect(_check(profile: null), RespondEligibility.noProfile);
    });

    test('closed requests cannot be responded to', () {
      expect(
        _check(
          request: _request(status: RequestStatus.fulfilled),
          profile: _donor,
        ),
        RespondEligibility.notOpen,
      );
    });

    test('unavailable donors cannot respond', () {
      expect(
        _check(profile: _donor.copyWith(isAvailable: false)),
        RespondEligibility.unavailable,
      );
    });

    test('a different blood type cannot respond', () {
      expect(
        _check(request: _request(bloodType: BloodType.aPositive), profile: _donor),
        RespondEligibility.bloodTypeMismatch,
      );
    });

    test('an earlier response is reported even if the request closed', () {
      expect(
        _check(
          request: _request(status: RequestStatus.fulfilled),
          profile: _donor,
          alreadyResponded: true,
        ),
        RespondEligibility.alreadyResponded,
      );
    });
  });

  group('RespondController', () {
    // Seed: 'user-2' is an O+ donor with profile 'donor-1';
    // 'request-1' is an open O+ request from 'user-1'.
    ProviderContainer containerForSeedDonor() {
      final container = ProviderContainer(
        overrides: [
          currentUserProvider.overrideWith(
            (ref) => SeedData.sample().users[1],
          ),
        ],
      );
      addTearDown(container.dispose);
      return container;
    }

    test('saves a response with the donor profile id, once', () async {
      final container = containerForSeedDonor();
      final request = SeedData.sample().bloodRequests.first;
      final controller = container.read(respondControllerProvider.notifier);

      expect(await controller.respond(request), isNull);

      final responses = await container
          .read(matchingRepositoryProvider)
          .getResponses(request.id);
      expect(responses.single.donorId, 'donor-1');
      expect(responses.single.status, ResponseStatus.pending);

      expect(
        await controller.respond(request),
        RespondEligibility.alreadyResponded.message,
      );
    });
  });
}
