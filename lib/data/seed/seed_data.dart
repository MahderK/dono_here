import '../../domain/models/blood_request.dart';
import '../../domain/models/donor_profile.dart';
import '../../domain/models/enums.dart';
import '../../domain/models/request_response.dart';
import '../../domain/models/user.dart';

class SeedData {
  const SeedData({
    required this.users,
    required this.donorProfiles,
    required this.bloodRequests,
    required this.responses,
  });

  final List<User> users;
  final List<DonorProfile> donorProfiles;
  final List<BloodRequest> bloodRequests;
  final List<RequestResponse> responses;

  factory SeedData.sample() {
    final createdAt = DateTime.utc(2026, 1, 1);
    final updatedAt = DateTime.utc(2026, 1, 10);

    return SeedData(
      users: [
        User(
          id: 'user-1',
          fullName: 'Ada Tesfaye',
          email: 'ada@example.com',
          phoneNumber: '+251911000001',
          role: UserRole.requester,
          createdAt: createdAt,
        ),
        User(
          id: 'user-2',
          fullName: 'Birhanu Kassa',
          email: 'birhanu@example.com',
          phoneNumber: '+251911000002',
          role: UserRole.donor,
          createdAt: createdAt,
        ),
        User(
          id: 'user-3',
          fullName: 'Chaltu Girma',
          email: 'chaltu@example.com',
          phoneNumber: '+251911000003',
          role: UserRole.donor,
          createdAt: createdAt,
        ),
      ],
      donorProfiles: [
        DonorProfile(
          id: 'donor-1',
          userId: 'user-2',
          bloodType: BloodType.oPositive,
          area: 'Bole',
          lastDonation: DateTime.utc(2025, 6, 1),
          latitude: 9.0108,
          longitude: 38.7612,
          isAvailable: true,
          isVisible: true,
          updatedAt: updatedAt,
        ),
        DonorProfile(
          id: 'donor-2',
          userId: 'user-3',
          bloodType: BloodType.aPositive,
          area: 'Piassa',
          latitude: 9.0320,
          longitude: 38.7500,
          isAvailable: true,
          isVisible: true,
          updatedAt: updatedAt,
        ),
      ],
      bloodRequests: [
        BloodRequest(
          id: 'request-1',
          requesterId: 'user-1',
          bloodTypeNeeded: BloodType.oPositive,
          unitsNeeded: 2,
          hospital: 'Tikur Anbessa',
          area: 'Bole',
          latitude: 9.0150,
          longitude: 38.7600,
          urgency: RequestUrgency.critical,
          status: RequestStatus.open,
          createdAt: updatedAt,
        ),
      ],
      responses: const [],
    );
  }
}
