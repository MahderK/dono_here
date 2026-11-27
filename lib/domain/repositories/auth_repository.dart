import '../models/enums.dart';
import '../models/user.dart';

abstract interface class AuthRepository {
  Future<User?> get currentUser;

  Future<User> signIn({
    required String email,
    required String password,
  });

  Future<User> register({
    required String fullName,
    required String email,
    required String phoneNumber,
    required UserRole role,
    required String password,
  });

  Future<void> signOut();
}
