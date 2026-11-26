import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dono_here/core/providers/repository_providers.dart';
import 'package:dono_here/domain/repositories/donor_repository.dart';

void main() {
  test('providers expose interface types backed by seeded data', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final donors = container.read(donorRepositoryProvider);

    expect(donors, isA<DonorRepository>());
    expect(
      (await donors.getAvailableDonors()).map((d) => d.id),
      contains('donor-1'),
    );
  });
}
