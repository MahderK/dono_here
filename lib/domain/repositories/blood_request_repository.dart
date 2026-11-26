import '../models/blood_request.dart';

abstract interface class BloodRequestRepository {
  Future<BloodRequest?> getRequest(String id);
  Future<List<BloodRequest>> getOpenRequests();
  Future<List<BloodRequest>> getRequestsByRequester(String requesterId);
  Future<BloodRequest> saveRequest(BloodRequest request);
}
