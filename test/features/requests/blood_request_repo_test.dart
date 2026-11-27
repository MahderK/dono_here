import 'package:flutter_test/flutter_test.dart';
// Replace with your real repo & model imports when ready:
// import 'package:dono_here/features/requests/data/repositories/in_memory_blood_request_repository.dart';
// import 'package:dono_here/features/requests/domain/entities/blood_request.dart';

class _TestRequest {
  _TestRequest({
    required this.id,
    required this.hospital,
    required this.bloodType,
    required this.units,
    this.status = 'open',
    this.respondedDonorIds = const [],
  });

  final String id;
  final String hospital;
  final String bloodType;
  final int units;
  final String status;
  final List<String> respondedDonorIds;

  _TestRequest copyWith({
    String? status,
    List<String>? respondedDonorIds,
  }) {
    return _TestRequest(
      id: id,
      hospital: hospital,
      bloodType: bloodType,
      units: units,
      status: status ?? this.status,
      respondedDonorIds: respondedDonorIds ?? this.respondedDonorIds,
    );
  }
}

class _InMemoryRequestStore {
  final Map<String, _TestRequest> _items = {};
  int _seq = 0;

  _TestRequest create({
    required String hospital,
    required String bloodType,
    required int units,
  }) {
    final id = 'req_${++_seq}';
    final req = _TestRequest(
      id: id,
      hospital: hospital,
      bloodType: bloodType,
      units: units,
    );
    _items[id] = req;
    return req;
  }

  void respond(String requestId, String donorId) {
    final current = _items[requestId];
    if (current == null) return;
    _items[requestId] = current.copyWith(
      respondedDonorIds: [...current.respondedDonorIds, donorId],
    );
  }

  void fulfill(String requestId) {
    final current = _items[requestId];
    if (current == null) return;
    _items[requestId] = current.copyWith(status: 'fulfilled');
  }

  _TestRequest? getById(String requestId) => _items[requestId];
}

void main() {
  test('creates a request, records donor response, and marks fulfilled', () {
    final store = _InMemoryRequestStore();

    final created = store.create(
      hospital: 'Tikur Anbessa',
      bloodType: 'O+',
      units: 2,
    );
    expect(created.id, isNotEmpty);
    expect(created.status, 'open');
    expect(created.respondedDonorIds, isEmpty);

    store.respond(created.id, 'donor_42');
    final afterRespond = store.getById(created.id)!;
    expect(afterRespond.respondedDonorIds, contains('donor_42'));

    store.fulfill(created.id);
    final afterFulfill = store.getById(created.id)!;
    expect(afterFulfill.status, 'fulfilled');
  });
}