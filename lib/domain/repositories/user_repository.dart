import '../models/user.dart';

abstract interface class UserRepository {
  Future<User?> getUser(String id);
  Future<List<User>> getUsers();
  Future<User> saveUser(User user);
}
