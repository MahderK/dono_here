import '../../domain/models/blood_request.dart';
import '../../domain/models/donor_profile.dart';
import '../../domain/models/enums.dart';
import '../../domain/models/request_response.dart';
import '../../domain/repositories/matching_repository.dart';
import 'in_memory_store.dart';

class InMemoryMatchingRepository implements MatchingRepository {
  InMemoryMatchingRepository(this._store);

  final InMemoryStore _store;

  @override
  Future<List<DonorProfile>> findDonorsFor(BloodRequest request) async => _store
      .donorProfiles
      .values
      .where(
        (donor) =>
            donor.isAvailable &&
            donor.isVisible &&
            donor.bloodType == request.bloodTypeNeeded,
      )
      .toList();

  @override
  Future<List<RequestResponse>> getResponses(String requestId) async => _store
      .responses
      .values
      .where((response) => response.requestId == requestId)
      .toList();

  @override
  Future<RequestResponse> respondToRequest({
    required String requestId,
    required String donorId,
  }) async {
    if (!_store.bloodRequests.containsKey(requestId)) {
      throw StateError('Blood request not found: $requestId');
    }
    if (!_store.donorProfiles.containsKey(donorId)) {
      throw StateError('Donor profile not found: $donorId');
    }

    final response = RequestResponse(
      id: 'response-$requestId-$donorId',
      requestId: requestId,
      donorId: donorId,
      status: ResponseStatus.pending,
      createdAt: DateTime.now(),
    );

    _store.responses[response.id] = response;
    return response;
  }
}
