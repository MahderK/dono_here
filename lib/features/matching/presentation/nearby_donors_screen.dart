import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/enum_labels.dart';
import '../../../domain/models/blood_request.dart';
import '../../../domain/models/donor_profile.dart';
import '../../requests/presentation/providers/requests_providers.dart';
import 'providers/matching_providers.dart';

class NearbyDonorsScreen extends ConsumerWidget {
  const NearbyDonorsScreen({super.key, required this.requestId});

  final String requestId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final request = ref.watch(requestDetailProvider(requestId));
    final donors = ref.watch(nearbyDonorsProvider(requestId));

    return Scaffold(
      appBar: AppBar(title: const Text('Nearby Donors')),
      body: request.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) =>
            Center(child: Text('Could not load request: $error')),
        data: (item) {
          if (item == null) {
            return const Center(child: Text('Request not found'));
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  '${item.hospital} · ${item.bloodTypeNeeded.label} · '
                  '${item.unitsNeeded} unit(s)',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Expanded(
                child: donors.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, _) =>
                      Center(child: Text('Could not load donors: $error')),
                  data: (list) {
                    if (list.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Text(
                            'No available matching donors right now.',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                      itemCount: list.length,
                      itemBuilder: (context, index) => _DonorTile(
                        donor: list[index],
                        request: item,
                      ),
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

class _DonorTile extends StatelessWidget {
  const _DonorTile({required this.donor, required this.request});

  final DonorProfile donor;
  final BloodRequest request;

  @override
  Widget build(BuildContext context) {
    final distance = distanceKm(
      fromLatitude: request.latitude,
      fromLongitude: request.longitude,
      toLatitude: donor.latitude,
      toLongitude: donor.longitude,
    );

    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text(donor.bloodType.label)),
        title: Text(donor.area),
        subtitle: Text(
          'Available · ${distance.toStringAsFixed(1)} km away · '
          'Updated ${donor.updatedAt.toLocal().toString().split(' ').first}',
        ),
      ),
    );
  }
}
