import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/router/routes.dart';
import '../../../core/utils/enum_labels.dart';
import '../../../domain/models/enums.dart';
import 'providers/requests_providers.dart';

class CreateRequestScreen extends ConsumerStatefulWidget {
  const CreateRequestScreen({super.key});

  @override
  ConsumerState<CreateRequestScreen> createState() =>
      _CreateRequestScreenState();
}

class _CreateRequestScreenState extends ConsumerState<CreateRequestScreen> {
  // Local form plumbing only (controllers / key / current field values).
  // The request itself is saved through myRequestsProvider.
  final _formKey = GlobalKey<FormState>();
  final _hospitalController = TextEditingController();
  final _unitsController = TextEditingController(text: '1');
  BloodType? _bloodType;
  RequestUrgency _urgency = RequestUrgency.medium;

  @override
  void dispose() {
    _hospitalController.dispose();
    _unitsController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);
    try {
      await ref
          .read(myRequestsProvider.notifier)
          .createRequest(
            bloodType: _bloodType!,
            units: int.parse(_unitsController.text.trim()),
            hospital: _hospitalController.text,
            urgency: _urgency,
          );
      if (!mounted) return;
      messenger.showSnackBar(
        const SnackBar(content: Text('Blood request posted')),
      );
      router.go(AppRoutes.myRequests);
    } catch (error) {
      messenger.showSnackBar(
        SnackBar(content: Text('Could not post request: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Request')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<BloodType>(
              initialValue: _bloodType,
              decoration: const InputDecoration(
                labelText: 'Blood type needed',
                border: OutlineInputBorder(),
              ),
              items: [
                for (final type in BloodType.values)
                  DropdownMenuItem(value: type, child: Text(type.label)),
              ],
              onChanged: (value) => _bloodType = value,
              validator: (value) =>
                  value == null ? 'Select a blood type' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _unitsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Units needed',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                final units = int.tryParse((value ?? '').trim());
                if (units == null) return 'Enter a whole number';
                if (units < 1 || units > 10) {
                  return 'Units must be between 1 and 10';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _hospitalController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Hospital',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                final hospital = (value ?? '').trim();
                if (hospital.isEmpty) return 'Enter the hospital name';
                if (hospital.length < 3) return 'Hospital name is too short';
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<RequestUrgency>(
              initialValue: _urgency,
              decoration: const InputDecoration(
                labelText: 'Urgency',
                border: OutlineInputBorder(),
              ),
              items: [
                for (final urgency in RequestUrgency.values)
                  DropdownMenuItem(value: urgency, child: Text(urgency.label)),
              ],
              onChanged: (value) {
                if (value != null) _urgency = value;
              },
            ),
            const SizedBox(height: 8),
            const Text(
              'Location: central Addis Ababa (default for Milestone 1).',
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _submit,
              child: const Text('Submit request'),
            ),
          ],
        ),
      ),
    );
  }
}
