// TEMPORARY FILE for T4 / T6 development.
//
// T3 (auth, Siham) is not merged yet, so nothing tells the app who is signed in.
// When T3 is merged, DELETE this file and point the two imports of it
// (donor_profile_providers.dart and home_providers.dart) at Siham's provider.
// Her provider must give a `User?` (null = signed out).
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/repository_providers.dart';
import '../../../../domain/models/user.dart';

/// Seed users: 'user-1' (no donor profile), 'user-2' (O+ donor in Bole),
/// 'user-3' (A+ donor in Piassa). Change this id to test different people.
const String _tempSignedInUserId = 'user-2';

final currentUserProvider = Provider<User?>(
  (ref) => ref.watch(inMemoryStoreProvider).users[_tempSignedInUserId],
);
