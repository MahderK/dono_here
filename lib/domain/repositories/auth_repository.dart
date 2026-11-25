import '../models/user.dart';

abstract interface class AuthRepository {
  Future<User?> get currentUser;
  Future<User> signIn({required String email});
  Future<void> signOut();
}
