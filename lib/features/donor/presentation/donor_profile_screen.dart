import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/utils/addis_areas.dart';
import '../../../core/utils/enum_labels.dart';
import '../../../domain/models/enums.dart';
import 'providers/donor_profile_providers.dart';

class DonorProfileScreen extends ConsumerWidget {
  const DonorProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(myDonorProfileProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Donor Profile')),
      body: profile.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) =>
            Center(child: Text('Could not load your profile: $error')),
        data: (_) => const _ProfileForm(),
      ),
    );
  }
}

class _ProfileForm extends ConsumerWidget {
  const _ProfileForm();

  Future<void> _pickDate(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(donorProfileFormProvider.notifier);
    final current = ref.read(donorProfileFormProvider).lastDonation;
    final picked = await showDatePicker(
      context: context,
      initialDate: current ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) notifier.setLastDonation(picked);
  }

  Future<void> _save(BuildContext context, WidgetRef ref) async {
    final saved = await ref.read(donorProfileFormProvider.notifier).submit();
    if (saved && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Profile saved')));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(donorProfileFormProvider);
    final notifier = ref.read(donorProfileFormProvider.notifier);

    // Keep an already-saved area selectable even if it is not in our list.
    final areas = [
      ...kAddisAreas,
      if (form.area.isNotEmpty && !kAddisAreas.contains(form.area)) form.area,
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        DropdownButtonFormField<BloodType>(
          initialValue: form.bloodType,
          isExpanded: true,
          decoration: InputDecoration(
            labelText: 'Blood type',
            border: const OutlineInputBorder(),
            errorText: form.bloodTypeError,
          ),
          items: [
            for (final type in BloodType.values)
              DropdownMenuItem(value: type, child: Text(type.label)),
          ],
          onChanged: notifier.setBloodType,
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          initialValue: form.area.isEmpty ? null : form.area,
          isExpanded: true,
          decoration: InputDecoration(
            labelText: 'Area',
            border: const OutlineInputBorder(),
            errorText: form.areaError,
          ),
          items: [
            for (final area in areas)
              DropdownMenuItem(value: area, child: Text(area)),
          ],
          onChanged: (value) => notifier.setArea(value ?? ''),
        ),
        const SizedBox(height: 8),
        SwitchListTile(
          title: const Text('Available to donate'),
          subtitle: const Text('Turn off if you cannot donate right now'),
          value: form.isAvailable,
          onChanged: notifier.setAvailable,
        ),
        SwitchListTile(
          title: const Text('Visible to requesters'),
          subtitle: const Text('Let people looking for blood find you'),
          value: form.isVisible,
          onChanged: notifier.setVisible,
        ),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          title: const Text('Last donation (optional)'),
          subtitle: Text(
            form.lastDonation == null
                ? 'Not set'
                : form.lastDonation!.toIso8601String().split('T').first,
          ),
          trailing: form.lastDonation == null
              ? const Icon(Icons.calendar_today)
              : IconButton(
                  icon: const Icon(Icons.clear),
                  tooltip: 'Clear date',
                  onPressed: () => notifier.setLastDonation(null),
                ),
          onTap: () => _pickDate(context, ref),
        ),
        if (form.saveError != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              form.saveError!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: form.isSaving ? null : () => _save(context, ref),
          child: form.isSaving
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Save profile'),
        ),
      ],
    );
  }
}
