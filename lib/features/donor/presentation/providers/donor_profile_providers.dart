import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/repository_providers.dart';
import '../../../../domain/models/donor_profile.dart';
import '../../../../domain/models/enums.dart';
// TEMP: replace with Siham's provider once T3 is merged.
import '../../../auth/presentation/providers/current_user_provider.dart';
import 'donor_profile_form_state.dart';

// The form has no map yet, so new profiles get a default location
// (central Addis Ababa). "Nearby" in M1 is matched by the area name instead.
const double _defaultLatitude = 9.0300;
const double _defaultLongitude = 38.7400;

/// Loads and saves the signed-in user's donor profile (null = no profile yet).
final myDonorProfileProvider =
    AsyncNotifierProvider<MyDonorProfileNotifier, DonorProfile?>(
      MyDonorProfileNotifier.new,
    );

class MyDonorProfileNotifier extends AsyncNotifier<DonorProfile?> {
  @override
  Future<DonorProfile?> build() async {
    final user = ref.watch(currentUserProvider);
    if (user == null) return null;
    return ref.watch(donorRepositoryProvider).getByUserId(user.id);
  }

  Future<void> save(DonorProfile profile) async {
    final saved = await ref
        .read(donorRepositoryProvider)
        .saveDonorProfile(profile);
    state = AsyncData(saved);
  }
}

/// The in-progress form: draft values, validation errors, saving flag.
final donorProfileFormProvider =
    NotifierProvider<DonorProfileFormNotifier, DonorProfileFormState>(
      DonorProfileFormNotifier.new,
    );

class DonorProfileFormNotifier extends Notifier<DonorProfileFormState> {
  @override
  DonorProfileFormState build() {
    // Starts from the saved profile (if any); rebuilt whenever it changes.
    final saved = ref.watch(myDonorProfileProvider).value;
    if (saved == null) return const DonorProfileFormState();
    return DonorProfileFormState(
      bloodType: saved.bloodType,
      area: saved.area,
      lastDonation: saved.lastDonation,
      isAvailable: saved.isAvailable,
      isVisible: saved.isVisible,
    );
  }

  void setBloodType(BloodType? value) =>
      state = state.copyWith(bloodType: value, bloodTypeError: null);

  void setArea(String value) =>
      state = state.copyWith(area: value, areaError: null);

  void setLastDonation(DateTime? value) =>
      state = state.copyWith(lastDonation: value);

  void setAvailable(bool value) => state = state.copyWith(isAvailable: value);

  void setVisible(bool value) => state = state.copyWith(isVisible: value);

  /// Validates and saves. Returns true when the profile was saved.
  Future<bool> submit() async {
    final bloodType = state.bloodType;
    final area = state.area.trim();
    if (bloodType == null || area.isEmpty) {
      state = state.copyWith(
        bloodTypeError: bloodType == null ? 'Choose your blood type' : null,
        areaError: area.isEmpty ? 'Choose your area' : null,
      );
      return false;
    }

    final user = ref.read(currentUserProvider);
    if (user == null) {
      state = state.copyWith(saveError: 'Please sign in first');
      return false;
    }

    state = state.copyWith(isSaving: true, saveError: null);
    try {
      final existing = ref.read(myDonorProfileProvider).value;
      final now = DateTime.now();
      final profile = existing == null
          ? DonorProfile(
              id: 'donor-${user.id}',
              userId: user.id,
              area: area,
              bloodType: bloodType,
              lastDonation: state.lastDonation,
              latitude: _defaultLatitude,
              longitude: _defaultLongitude,
              isAvailable: state.isAvailable,
              isVisible: state.isVisible,
              updatedAt: now,
            )
          : existing.copyWith(
              area: area,
              bloodType: bloodType,
              lastDonation: state.lastDonation,
              isAvailable: state.isAvailable,
              isVisible: state.isVisible,
              updatedAt: now,
            );
      // Saving updates myDonorProfileProvider, which rebuilds this form state
      // from the saved profile (and clears isSaving).
      await ref.read(myDonorProfileProvider.notifier).save(profile);
      return true;
    } catch (e) {
      state = state.copyWith(isSaving: false, saveError: 'Could not save: $e');
      return false;
    }
  }
}
