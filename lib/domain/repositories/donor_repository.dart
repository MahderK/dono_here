import '../models/donor_profile.dart';

abstract interface class DonorRepository {
  Future<DonorProfile?> getDonorProfile(String id);
  Future<DonorProfile?> getByUserId(String userId);
  Future<List<DonorProfile>> getAvailableDonors();
  Future<DonorProfile> saveDonorProfile(DonorProfile profile);
}
