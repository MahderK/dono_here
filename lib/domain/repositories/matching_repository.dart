import '../models/request_response.dart';
import '../models/donor_profile.dart';
import '../models/blood_request.dart';

abstract interface class MatchingRepository {
  Future<List<DonorProfile>> findDonorsFor(BloodRequest request);
  Future<List<RequestResponse>> getResponses(String requestId);
  Future<RequestResponse> respondToRequest({
    required String requestId,
    required String donorId,
  });
}
