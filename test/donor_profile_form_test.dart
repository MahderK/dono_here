import 'package:dono_here/core/providers/repository_providers.dart';
import 'package:dono_here/data/seed/seed_data.dart';
import 'package:dono_here/domain/models/enums.dart';
import 'package:dono_here/features/auth/presentation/providers/current_user_provider.dart';
import 'package:dono_here/features/donor/presentation/providers/donor_profile_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// 'user-1' is a seed user with no donor profile yet.
ProviderContainer _containerForUserWithoutProfile() {
  final container = ProviderContainer(
    overrides: [
      currentUserProvider.overrideWith((ref) => SeedData.sample().users.first),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('submit with an empty form shows errors and saves nothing', () async {
    final container = _containerForUserWithoutProfile();
    await container.read(myDonorProfileProvider.future);

    final saved = await container
        .read(donorProfileFormProvider.notifier)
        .submit();

    expect(saved, isFalse);
    final form = container.read(donorProfileFormProvider);
    expect(form.bloodTypeError, isNotNull);
    expect(form.areaError, isNotNull);
    expect(await container.read(donorRepositoryProvider).getByUserId('user-1'),
        isNull);
  });

  test('submit with valid values saves the profile in the repository', () async {
    final container = _containerForUserWithoutProfile();
    await container.read(myDonorProfileProvider.future);

    container.read(donorProfileFormProvider.notifier)
      ..setBloodType(BloodType.bPositive)
      ..setArea('Bole');
    final saved = await container
        .read(donorProfileFormProvider.notifier)
        .submit();

    expect(saved, isTrue);
    final stored = await container
        .read(donorRepositoryProvider)
        .getByUserId('user-1');
    expect(stored, isNotNull);
    expect(stored!.bloodType, BloodType.bPositive);
    expect(stored.area, 'Bole');
    expect(stored.isAvailable, isTrue);
  });
}
