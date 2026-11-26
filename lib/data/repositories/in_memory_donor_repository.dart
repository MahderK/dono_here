import '../../domain/models/donor_profile.dart';
import '../../domain/repositories/donor_repository.dart';
import 'in_memory_store.dart';

class InMemoryDonorRepository implements DonorRepository {
  InMemoryDonorRepository(this._store);

  final InMemoryStore _store;

  @override
  Future<DonorProfile?> getDonorProfile(String id) async =>
      _store.donorProfiles[id];

  @override
  Future<DonorProfile?> getByUserId(String userId) async {
    for (final donor in _store.donorProfiles.values) {
      if (donor.userId == userId) return donor;
    }
    return null;
  }

  @override
  Future<List<DonorProfile>> getAvailableDonors() async => _store
      .donorProfiles
      .values
      .where((d) => d.isAvailable && d.isVisible)
      .toList();

  @override
  Future<DonorProfile> saveDonorProfile(DonorProfile profile) async {
    _store.donorProfiles[profile.id] = profile;
    return profile;
  }
}
