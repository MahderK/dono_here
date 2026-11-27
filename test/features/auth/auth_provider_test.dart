import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _SessionState {
  const _SessionState({this.email, this.role});
  final String? email;
  final String? role;

  bool get isAuthenticated => email != null;
}

class _SessionNotifier extends Notifier<_SessionState> {
  @override
  _SessionState build() => const _SessionState();

  void register({required String email, required String role}) {
    state = _SessionState(email: email, role: role);
  }

  void signIn({required String email}) {
    state = _SessionState(email: email, role: state.role ?? 'donor');
  }

  void signOut() {
    state = const _SessionState();
  }
}

final _sessionProvider =
    NotifierProvider<_SessionNotifier, _SessionState>(_SessionNotifier.new);

void main() {
  test('register, signOut, and signIn update current session in ProviderContainer', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(_sessionProvider).isAuthenticated, isFalse);

    container
        .read(_sessionProvider.notifier)
        .register(email: 'siham@dono.et', role: 'donor');
    expect(container.read(_sessionProvider).isAuthenticated, isTrue);
    expect(container.read(_sessionProvider).email, 'siham@dono.et');

    container.read(_sessionProvider.notifier).signOut();
    expect(container.read(_sessionProvider).isAuthenticated, isFalse);
    expect(container.read(_sessionProvider).email, isNull);

    container.read(_sessionProvider.notifier).signIn(email: 'siham@dono.et');
    expect(container.read(_sessionProvider).isAuthenticated, isTrue);
    expect(container.read(_sessionProvider).email, 'siham@dono.et');
  });
}