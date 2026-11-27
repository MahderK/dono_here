import 'package:dono_here/features/auth/presentation/providers/auth_provider.dart';
import 'package:dono_here/features/auth/presentation/providers/current_user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('currentUserProvider follows the real auth session', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(currentUserProvider), isNull);

    await container.read(authProvider.notifier).signIn(
          email: 'birhanu@example.com',
          password: 'password123',
        );

    expect(container.read(currentUserProvider)?.id, 'user-2');
    expect(container.read(currentUserProvider)?.email, 'birhanu@example.com');

    await container.read(authProvider.notifier).signOut();

    expect(container.read(currentUserProvider), isNull);
  });
}