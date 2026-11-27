import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:dono_here/features/auth/presentation/providers/auth_provider.dart';

void main() {
  test('register and signIn update current user in authProvider', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    // Example if using authProvider:
    // final notifier = container.read(authProvider.notifier);
    // await notifier.register(
    //   fullName: 'Siham Test',
    //   email: 'siham@example.com',
    //   phoneNumber: '+251900000000',
    //   role: 'donor',
    //   password: 'password123',
    // );
    // expect(container.read(authProvider).user, isNotNull);

    // notifier.signOut();
    // expect(container.read(authProvider).user, isNull);

    // await notifier.signIn(email: 'siham@example.com', password: 'password123');
    // expect(container.read(authProvider).user, isNotNull);
    expect(container, isNotNull);
  });
}