import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/repository_providers.dart';
import '../../../../domain/models/blood_request.dart';
import '../../../../domain/models/donor_profile.dart';

typedef NearbyDonorsResult = ({
  BloodRequest request,
  List<DonorProfile> donors,
});

String _normalizeArea(String value) => value.trim().toLowerCase();

/// Milestone 1 definition of "nearby": the donor's area text equals the
/// request's area text, ignoring case and surrounding whitespace.
bool isSameArea(BloodRequest request, DonorProfile donor) {
  final requestArea = _normalizeArea(request.area);
  final donorArea = _normalizeArea(donor.area);
  return requestArea.isNotEmpty &&
      donorArea.isNotEmpty &&
      requestArea == donorArea;
}

/// Suggestion order: available first, same area next, most recently updated
/// next, then a deterministic alphabetical/id tie-break.

List<DonorProfile> sortDonorSuggestions(
  BloodRequest request,
  Iterable<DonorProfile> donors,
) {
  final sorted = donors.toList();

  sorted.sort((a, b) {
    final byAvailability = (b.isAvailable ? 1 : 0).compareTo(
      a.isAvailable ? 1 : 0,
    );
    if (byAvailability != 0) return byAvailability;

    final byArea = (isSameArea(request, b) ? 1 : 0).compareTo(
      isSameArea(request, a) ? 1 : 0,
    );
    if (byArea != 0) return byArea;

    final byRecency = b.updatedAt.compareTo(a.updatedAt);
    if (byRecency != 0) return byRecency;

    final byAreaName = _normalizeArea(a.area).compareTo(_normalizeArea(b.area));
    if (byAreaName != 0) return byAreaName;

    return a.id.compareTo(b.id);
  });

  return sorted;
}

/// `null` means the request id does not exist.
final nearbyDonorsProvider = FutureProvider.family<NearbyDonorsResult?, String>(
  (ref, requestId) async {
    final request = await ref
        .watch(bloodRequestRepositoryProvider)
        .getRequest(requestId);
    if (request == null) return null;

    final candidates = await ref
        .watch(matchingRepositoryProvider)
        .findDonorsFor(request);

    // Defensive re-filter: `findDonorsFor` already do blood type +
    // availability + visibility, but keeping it here makes the guarantee
    // explicit and easy to unit-test
    final eligible = candidates.where(
      (donor) =>
          donor.isAvailable &&
          donor.isVisible &&
          donor.bloodType == request.bloodTypeNeeded,
    );

    return (request: request, donors: sortDonorSuggestions(request, eligible));
  },
);
