import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/router/routes.dart';
import '../../../core/utils/enum_labels.dart';
import '../../../domain/models/enums.dart';
import '../../../core/utils/date_format.dart';
import 'providers/requests_providers.dart';

class RequestDetailScreen extends ConsumerWidget {
  const RequestDetailScreen({super.key, required this.requestId});

  final String requestId;

  Future<void> _markFulfilled(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(myRequestsProvider.notifier).fulfillRequest(requestId);
      messenger.showSnackBar(
        const SnackBar(content: Text('Request marked as fulfilled')),
      );
    } catch (error) {
      messenger.showSnackBar(
        SnackBar(content: Text('Could not update request: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final request = ref.watch(requestDetailProvider(requestId));
    final currentUserId = ref.watch(currentRequesterIdProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Request Detail')),
      body: request.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) =>
            Center(child: Text('Could not load request: $error')),
        data: (item) {
          if (item == null) {
            return const Center(child: Text('Request not found'));
          }

          final isRequester = currentUserId == item.requesterId;
          final canFulfill =
              isRequester &&
              item.status != RequestStatus.fulfilled &&
              item.status != RequestStatus.cancelled;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                item.hospital,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Chip(label: Text(item.status.label)),
              ),
              const SizedBox(height: 16),
              _InfoRow(
                label: 'Blood type needed',
                value: item.bloodTypeNeeded.label,
              ),
              _InfoRow(label: 'Units needed', value: '${item.unitsNeeded}'),
              _InfoRow(label: 'Urgency', value: item.urgency.label),
              _InfoRow(label: 'Posted', value: formatDate(item.createdAt)),
              const SizedBox(height: 24),
              if (canFulfill) ...[
                FilledButton(
                  onPressed: () => _markFulfilled(context, ref),
                  child: const Text('Mark as fulfilled'),
                ),
                const SizedBox(height: 12),
              ],
              OutlinedButton(
                onPressed: () =>
                    context.push(AppRoutes.nearbyDonorsPath(requestId)),
                child: const Text('View Nearby Donors'),
              ),
              // The donor "respond" section is added below by the donor-side PR.
            ],
          );
        },
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
