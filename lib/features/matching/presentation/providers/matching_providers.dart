import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/repository_providers.dart';
import '../../../../domain/models/blood_request.dart';
import '../../../../domain/models/donor_profile.dart';
import '../../../../domain/models/request_response.dart';
import '../../../donor/presentation/providers/donor_profile_providers.dart';
import '../../../requests/presentation/providers/requests_providers.dart';

/// Straight-line distance in kilometres between two Addis Ababa coordinates.
/// Good enough for Milestone 1's in-memory "nearby" ordering.
double distanceKm({
  required double fromLatitude,
  required double fromLongitude,
  required double toLatitude,
  required double toLongitude,
}) {
  const double earthRadiusKm = 6371;
  final dLat = _toRadians(toLatitude - fromLatitude);
  final dLon = _toRadians(toLongitude - fromLongitude);
  final lat1 = _toRadians(fromLatitude);
  final lat2 = _toRadians(toLatitude);

  final a = math.pow(math.sin(dLat / 2), 2) +
      math.cos(lat1) * math.cos(lat2) * math.pow(math.sin(dLon / 2), 2);
  return earthRadiusKm * 2 * math.asin(math.sqrt(a));
}

double _toRadians(double degrees) => degrees * math.pi / 180;

/// Donors that can answer a request, nearest first.
final nearbyDonorsProvider =
    FutureProvider.family<List<DonorProfile>, String>((ref, requestId) async {
  final request = await ref.watch(requestDetailProvider(requestId).future);
  if (request == null) return const [];

  final donors = await ref
      .watch(matchingRepositoryProvider)
      .findDonorsFor(request);
  return [...donors]
    ..sort((a, b) => distanceKm(
          fromLatitude: request.latitude,
          fromLongitude: request.longitude,
          toLatitude: a.latitude,
          toLongitude: a.longitude,
        ).compareTo(distanceKm(
          fromLatitude: request.latitude,
          fromLongitude: request.longitude,
          toLatitude: b.latitude,
          toLongitude: b.longitude,
        )));
});

/// Responses already recorded for a request; used to avoid double-responding.
final requestResponsesProvider =
    FutureProvider.family<List<RequestResponse>, String>((ref, requestId) {
  return ref.watch(matchingRepositoryProvider).getResponses(requestId);
});

/// Open requests shown on Home.
///
/// A signed-in donor with a saved profile sees only requests matching their
/// blood type, nearest first. Everyone else gets the full open list (useful
/// for the requester side of the milestone demo).
final visibleOpenRequestsProvider = FutureProvider<List<BloodRequest>>((ref) async {
  final open = await ref.watch(openRequestsProvider.future);
  final profile = await ref.watch(myDonorProfileProvider.future);

  if (profile == null || !profile.isAvailable || !profile.isVisible) {
    return open;
  }

  final matching = open
      .where((request) => request.bloodTypeNeeded == profile.bloodType)
      .toList();
  return matching
    ..sort((a, b) => distanceKm(
          fromLatitude: profile.latitude,
          fromLongitude: profile.longitude,
          toLatitude: a.latitude,
          toLongitude: a.longitude,
        ).compareTo(distanceKm(
          fromLatitude: profile.latitude,
          fromLongitude: profile.longitude,
          toLatitude: b.latitude,
          toLongitude: b.longitude,
        )));
});
