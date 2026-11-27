import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../domain/models/blood_request.dart';
// TEMP: replace with Siham's provider once T3 is merged.
import '../../../auth/presentation/providers/current_user_provider.dart';
import '../providers/donor_profile_providers.dart';
import '../providers/respond_providers.dart';
import 'complete_profile_prompt.dart';

/// The donor side of the Request detail screen. Drop it into the detail
/// screen with `RespondSection(request: request)`. It decides by itself what
/// to show: nothing (own request), a profile prompt, a message, or the
/// Respond button.
class RespondSection extends ConsumerWidget {
  const RespondSection({super.key, required this.request});

  final BloodRequest request;

  Future<void> _respond(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final error = await ref
        .read(respondControllerProvider.notifier)
        .respond(request);
    messenger.showSnackBar(
      SnackBar(content: Text(error ?? 'Thank you! Your response was sent.')),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(currentUserProvider)?.id;
    final profileAsync = ref.watch(myDonorProfileProvider);
    final responseAsync = ref.watch(myResponseProvider(request.id));
    final sending = ref.watch(respondControllerProvider).contains(request.id);

    if (profileAsync.isLoading || responseAsync.isLoading) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (profileAsync.hasError || responseAsync.hasError) {
      return const _InfoCard(
        icon: Icons.error_outline,
        message: 'Could not check your donor status.',
      );
    }

    final eligibility = checkRespondEligibility(
      request: request,
      userId: userId,
      profile: profileAsync.value,
      alreadyResponded: responseAsync.value != null,
    );

    return switch (eligibility) {
      RespondEligibility.ownRequest => const SizedBox.shrink(),
      RespondEligibility.noProfile => const CompleteProfilePrompt(
        message: 'Complete your donor profile to respond to this request.',
      ),
      RespondEligibility.alreadyResponded => _InfoCard(
        icon: Icons.check_circle_outline,
        message: eligibility.message,
      ),
      RespondEligibility.canRespond => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: FilledButton.icon(
          onPressed: sending ? null : () => _respond(context, ref),
          icon: const Icon(Icons.volunteer_activism),
          label: Text(sending ? 'Sending...' : 'Respond'),
        ),
      ),
      _ => _InfoCard(icon: Icons.info_outline, message: eligibility.message),
    };
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(leading: Icon(icon), title: Text(message)),
    );
  }
}
