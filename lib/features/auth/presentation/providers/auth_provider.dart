import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/repository_providers.dart';
import '../../../../domain/models/enums.dart';
import '../../../../domain/models/user.dart';

class AuthState {
  const AuthState({
    this.user,
    this.isLoading = false,
    this.errorMessage,
  });

  final User? user;
  final bool isLoading;
  final String? errorMessage;

  AuthState copyWith({
    User? user,
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
      final user = await ref.read(authRepositoryProvider).signIn(
            email: email.trim(),
            password: password,
          );

      state = state.copyWith(
        user: user,
        isLoading: false,
      );
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _friendlyError(error),
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
      final userRole = UserRole.values.firstWhere(
        (value) => value.name == role,
        orElse: () => throw StateError('Unknown role: $role'),
      );

      final user = await ref.read(authRepositoryProvider).register(
            fullName: fullName.trim(),
            email: email.trim(),
            phoneNumber: phoneNumber.trim(),
            role: userRole,
            password: password,
          );

      state = state.copyWith(
        user: user,
        isLoading: false,
      );
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _friendlyError(error),
      );
    }
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();

    state = state.copyWith(
      clearUser: true,
      clearError: true,
      isLoading: false,
    );
  }
}

String _friendlyError(Object error) {
  if (error is StateError) return error.message;
  return error.toString();
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);