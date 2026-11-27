import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/utils/enum_labels.dart';
import '../providers/donor_profile_providers.dart';
import '../providers/matching_requests_providers.dart';
import 'complete_profile_prompt.dart';

/// The donor's Home list: open requests that match the donor's blood type,
/// or the "complete your profile" prompt when there is no profile yet.
/// It has no Scaffold, so it can be used as (part of) the Home screen body.
class MatchingRequestsView extends ConsumerWidget {
  const MatchingRequestsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(myDonorProfileProvider);

    return profile.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) =>
          Center(child: Text('Could not load your profile: $error')),
      data: (donor) => donor == null
          ? const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CompleteProfilePrompt()),
            )
          : const _MatchingList(),
    );
  }
}

class _MatchingList extends ConsumerWidget {
  const _MatchingList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requests = ref.watch(matchingRequestsProvider);

    return requests.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Could not load requests: $error'),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => ref.invalidate(matchingRequestsProvider),
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
      data: (items) => RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(matchingRequestsProvider);
          await ref.read(matchingRequestsProvider.future);
        },
        child: items.isEmpty
            ? ListView(
                children: const [
                  SizedBox(height: 120),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'No open requests match your blood type right now.\nPull down to refresh.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              )
            : ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 88),
                itemCount: items.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final item = items[index];
                  final request = item.request;
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 24,
                        child: Text(
                          request.bloodTypeNeeded.label,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(request.hospital),
                      subtitle: Text(
                        '${request.unitsNeeded} unit(s) needed · ${request.urgency.label} urgency',
                      ),
                      trailing: item.hasResponded
                          ? const Chip(label: Text('Responded'))
                          : const Icon(Icons.chevron_right),
                      onTap: () => context.push(
                        AppRoutes.requestDetailPath(request.id),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
