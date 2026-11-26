import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/in_memory_auth_repository.dart';
import '../../data/repositories/in_memory_blood_request_repository.dart';
import '../../data/repositories/in_memory_donor_repository.dart';
import '../../data/repositories/in_memory_matching_repository.dart';
import '../../data/repositories/in_memory_store.dart';
import '../../data/repositories/in_memory_user_repository.dart';
import '../../data/seed/seed_data.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/blood_request_repository.dart';
import '../../domain/repositories/donor_repository.dart';
import '../../domain/repositories/matching_repository.dart';
import '../../domain/repositories/user_repository.dart';

final seedDataProvider = Provider<SeedData>((ref) => SeedData.sample());

final inMemoryStoreProvider = Provider<InMemoryStore>((ref) {
  final seed = ref.watch(seedDataProvider);
  return InMemoryStore(
    users: seed.users,
    donorProfiles: seed.donorProfiles,
    bloodRequests: seed.bloodRequests,
    responses: seed.responses,
  );
});

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => InMemoryAuthRepository(ref.watch(inMemoryStoreProvider)),
);

final userRepositoryProvider = Provider<UserRepository>(
  (ref) => InMemoryUserRepository(ref.watch(inMemoryStoreProvider)),
);

final donorRepositoryProvider = Provider<DonorRepository>(
  (ref) => InMemoryDonorRepository(ref.watch(inMemoryStoreProvider)),
);

final bloodRequestRepositoryProvider = Provider<BloodRequestRepository>(
  (ref) => InMemoryBloodRequestRepository(ref.watch(inMemoryStoreProvider)),
);

final matchingRepositoryProvider = Provider<MatchingRepository>(
  (ref) => InMemoryMatchingRepository(ref.watch(inMemoryStoreProvider)),
);
