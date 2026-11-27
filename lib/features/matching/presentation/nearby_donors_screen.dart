import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/utils/date_format.dart';
import '../../../core/utils/enum_labels.dart';
import '../../../domain/models/donor_profile.dart';
import 'providers/nearby_donors_providers.dart';

class NearbyDonorsScreen extends ConsumerWidget {
  const NearbyDonorsScreen({super.key, required this.requestId});

  final String requestId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(nearbyDonorsProvider(requestId));

    return Scaffold(
      appBar: AppBar(title: const Text('Nearby Donors')),
      body: result.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) =>
            Center(child: Text('Could not load donors: $error')),
        data: (data) {
          if (data == null) {
            return const Center(child: Text('Request not found'));
          }

          final request = data.request;
          final donors = data.donors;

          if (donors.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'No matching donors right now.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                child: Text(
                  '${request.hospital} · ${request.bloodTypeNeeded.label}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'In Milestone 1, "nearby" means the donor area text matches '
                  'the request area'
                  '${request.area.isEmpty ? '' : ' (${request.area})'}'
                  '. Availability may be stale — check last updated.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: donors.length,
                  itemBuilder: (context, index) {
                    final donor = donors[index];
                    return _DonorCard(
                      donor: donor,
                      sameArea: isSameArea(request, donor),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DonorCard extends StatelessWidget {
  const _DonorCard({required this.donor, required this.sameArea});

  final DonorProfile donor;
  final bool sameArea;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(child: Text(donor.bloodType.label)),
        title: Text(donor.area),
        subtitle: Text(
          '${donor.isAvailable ? 'Available' : 'Unavailable'}'
          ' • Last updated ${formatDate(donor.updatedAt)}',
        ),
        trailing: sameArea ? const Chip(label: Text('Same area')) : null,
      ),
    );
  }
}
