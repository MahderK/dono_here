import '../../domain/models/blood_request.dart';
import '../../domain/models/donor_profile.dart';
import '../../domain/models/request_response.dart';
import '../../domain/models/user.dart';

class InMemoryStore {
  InMemoryStore({
    List<User> users = const [],
    List<DonorProfile> donorProfiles = const [],
    List<BloodRequest> bloodRequests = const [],
    List<RequestResponse> responses = const [],
  }) : users = {for (final u in users) u.id: u},
       donorProfiles = {for (final d in donorProfiles) d.id: d},
       bloodRequests = {for (final r in bloodRequests) r.id: r},
       responses = {for (final r in responses) r.id: r};

  final Map<String, User> users;
  final Map<String, DonorProfile> donorProfiles;
  final Map<String, BloodRequest> bloodRequests;
  final Map<String, RequestResponse> responses;
}
