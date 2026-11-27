import 'package:flutter_riverpod/flutter_riverpod.dart';
// Replace these imports with your project's actual paths if different:
// import 'package:dono_here/features/auth/domain/entities/user.dart';
// import 'package:dono_here/features/auth/domain/repositories/auth_repository.dart';

class AuthState {
  const AuthState({
    this.user,
    this.isLoading = false,
    this.errorMessage,
  });

  final dynamic user; // Replace `dynamic` with `User?`
  final bool isLoading;
  final String? errorMessage;

  AuthState copyWith({
    dynamic user,
    bool clearUser = false,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AuthState(
      user: clearUser ? null : (user ?? this.user),
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() => const AuthState();

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      // Call your AuthRepository method here, e.g.:
      // final repo = ref.read(authRepositoryProvider);
      // final user = await repo.signIn(email: email, password: password);
      final user = {'email': email};
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Sign in failed: $e',
      );
    }
  }

  Future<void> register({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String role,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      // Call your AuthRepository register method here
      final user = {
        'fullName': fullName,
        'email': email,
        'phoneNumber': phoneNumber,
        'role': role,
      };
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Registration failed: $e',
      );
    }
  }

  void signOut() {
    state = state.copyWith(clearUser: true, clearError: true);
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);