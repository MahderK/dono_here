import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/models/user.dart';
import 'auth_provider.dart';

final currentUserProvider = Provider<User?>(
  (ref) => ref.watch(authProvider).user,
);