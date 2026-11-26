import '../../domain/models/user.dart';
import '../../domain/repositories/auth_repository.dart';
import 'in_memory_store.dart';

class InMemoryAuthRepository implements AuthRepository {
  InMemoryAuthRepository(this._store);

  final InMemoryStore _store;
  String? _currentUserId;

  @override
  Future<User?> get currentUser async {
    final id = _currentUserId;
    if (id == null) return null;
    return _store.users[id];
  }

  @override
  Future<User> signIn({required String email}) async {
    for (final user in _store.users.values) {
      if (user.email == email) {
        _currentUserId = user.id;
        return user;
      }
    }
    throw StateError('No user found with email: $email');
  }

  @override
  Future<void> signOut() async {
    _currentUserId = null;
  }
}
