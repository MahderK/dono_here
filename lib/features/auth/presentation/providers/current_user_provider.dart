// TEMPORARY FILE until T3 (auth, Siham) is merged.
//
// There is ONE temporary "who is signed in" switch for the whole app:
// currentRequesterIdProvider in requests_providers.dart (returns a user id).
// This provider just turns that id into the seeded User, so the donor side and
// the requests side always agree on who the current user is.
//
// When T3 is merged: delete this file and point the donor files at Siham's
// provider (it must give a `User?`, null = signed out).
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/repository_providers.dart';
import '../../../../domain/models/user.dart';
import '../../../requests/presentation/providers/requests_providers.dart';

final currentUserProvider = Provider<User?>((ref) {
  final id = ref.watch(currentRequesterIdProvider);
  if (id == null) return null;
  return ref.watch(inMemoryStoreProvider).users[id];
});
