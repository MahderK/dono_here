import '../../domain/models/user.dart';
import '../../domain/repositories/user_repository.dart';
import 'in_memory_store.dart';

class InMemoryUserRepository implements UserRepository {
  InMemoryUserRepository(this._store);

  final InMemoryStore _store;

  @override
  Future<User?> getUser(String id) async => _store.users[id];

  @override
  Future<List<User>> getUsers() async => _store.users.values.toList();

  @override
  Future<User> saveUser(User user) async {
    _store.users[user.id] = user;
    return user;
  }
}
