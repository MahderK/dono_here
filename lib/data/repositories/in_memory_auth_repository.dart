import '../../domain/models/enums.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/auth_repository.dart';
import 'in_memory_store.dart';

class InMemoryAuthRepository implements AuthRepository {
  InMemoryAuthRepository(this._store) {
    // Demo credential for every seeded user; new users keep what they register with.
    for (final user in _store.users.values) {
      _passwords[_key(user.email)] = demoPassword;
    }
  }

  static const String demoPassword = 'password123';

  final InMemoryStore _store;
  final Map<String, String> _passwords = {};
  String? _currentUserId;

  @override
  Future<User?> get currentUser async {
    final id = _currentUserId;
    if (id == null) return null;
    return _store.users[id];
  }

  @override
  Future<User> signIn({
    required String email,
    required String password,
  }) async {
    final key = _key(email);
    final user = _store.users.values.firstWhere(
      (user) => _key(user.email) == key,
      orElse: () => throw StateError('No user found with email: $email'),
    );

    if (_passwords[key] != password) {
      throw StateError('Incorrect password');
    }

    _currentUserId = user.id;
    return user;
  }

  @override
  Future<User> register({
    required String fullName,
    required String email,
    required String phoneNumber,
    required UserRole role,
    required String password,
  }) async {
    final key = _key(email);

    if (_store.users.values.any((user) => _key(user.email) == key)) {
      throw StateError('An account with this email already exists');
    }

    final now = DateTime.now();
    final user = User(
      id: 'user-${now.microsecondsSinceEpoch}',
      fullName: fullName.trim(),
      email: key,
      phoneNumber: phoneNumber.trim(),
      role: role,
      createdAt: now,
    );

    _store.users[user.id] = user;
    _passwords[key] = password;
    _currentUserId = user.id;
    return user;
  }

  @override
  Future<void> signOut() async {
    _currentUserId = null;
  }

  String _key(String email) => email.trim().toLowerCase();
}
