import '../../domain/models/blood_request.dart';
import '../../domain/repositories/blood_request_repository.dart';
import '../../domain/models/enums.dart';
import 'in_memory_store.dart';

class InMemoryBloodRequestRepository implements BloodRequestRepository {
  InMemoryBloodRequestRepository(this._store);

  final InMemoryStore _store;

  @override
  Future<BloodRequest?> getRequest(String id) async => _store.bloodRequests[id];

  @override
  Future<List<BloodRequest>> getOpenRequests() async => _store
      .bloodRequests
      .values
      .where((r) => r.status == RequestStatus.open)
      .toList();

  @override
  Future<List<BloodRequest>> getRequestsByRequester(String requesterId) async =>
      _store.bloodRequests.values
          .where((r) => r.requesterId == requesterId)
          .toList();

  @override
  Future<BloodRequest> saveRequest(BloodRequest request) async {
    _store.bloodRequests[request.id] = request;
    return request;
  }
}
