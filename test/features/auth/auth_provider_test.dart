import 'package:dono_here/domain/models/enums.dart';
import 'package:dono_here/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const demoPassword = 'password123';

  ProviderContainer createContainer() {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    return container;
  }

  test('signIn sets the authenticated user from the repository', () async {
    final container = createContainer();

    await container.read(authProvider.notifier).signIn(
          email: 'birhanu@example.com',
          password: demoPassword,
        );

    final state = container.read(authProvider);
    expect(state.user?.id, 'user-2');
    expect(state.user?.email, 'birhanu@example.com');
    expect(state.isLoading, isFalse);
    expect(state.errorMessage, isNull);
  });

  test('signIn rejects a wrong password', () async {
    final container = createContainer();

    await container.read(authProvider.notifier).signIn(
          email: 'birhanu@example.com',
          password: 'wrong-password',
        );

    final state = container.read(authProvider);
    expect(state.user, isNull);
    expect(state.errorMessage, contains('Incorrect password'));
  });

  test('register creates a user and signs them in', () async {
    final container = createContainer();

    await container.read(authProvider.notifier).register(
          fullName: 'Test Donor',
          email: 'new.donor@example.com',
          phoneNumber: '0911000000',
          role: 'donor',
          password: demoPassword,
        );

    final state = container.read(authProvider);
    expect(state.user?.email, 'new.donor@example.com');
    expect(state.user?.role, UserRole.donor);
    expect(state.errorMessage, isNull);
  });

  test('signOut clears the authenticated user', () async {
    final container = createContainer();

    await container.read(authProvider.notifier).signIn(
          email: 'birhanu@example.com',
          password: demoPassword,
        );
    await container.read(authProvider.notifier).signOut();

    expect(container.read(authProvider).user, isNull);
  });
}