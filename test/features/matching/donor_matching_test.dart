import 'package:flutter_test/flutter_test.dart';

class _CandidateDonor {
  const _CandidateDonor({
    required this.id,
    required this.bloodType,
    required this.area,
    required this.isAvailable,
    required this.updatedAt,
  });

  final String id;
  final String bloodType;
  final String area;
  final bool isAvailable;
  final DateTime updatedAt;
}

List<_CandidateDonor> rankMatchingDonors({
  required List<_CandidateDonor> donors,
  required String neededBloodType,
  required String targetArea,
}) {
  final matches = donors
      .where((d) => d.bloodType == neededBloodType && d.isAvailable)
      .toList();

  matches.sort((a, b) {
    final aSameArea = a.area.toLowerCase() == targetArea.toLowerCase() ? 0 : 1;
    final bSameArea = b.area.toLowerCase() == targetArea.toLowerCase() ? 0 : 1;
    if (aSameArea != bSameArea) return aSameArea.compareTo(bSameArea);
    return b.updatedAt.compareTo(a.updatedAt);
  });

  return matches;
}

void main() {
  test('filters to available matching blood type and sorts same-area + newer first', () {
    final donors = [
      _CandidateDonor(
        id: 'unavailable_match',
        bloodType: 'A+',
        area: 'Bole',
        isAvailable: false,
        updatedAt: DateTime(2026, 11, 27, 12, 0),
      ),
      _CandidateDonor(
        id: 'wrong_type',
        bloodType: 'O-',
        area: 'Bole',
        isAvailable: true,
        updatedAt: DateTime(2026, 11, 27, 13, 0),
      ),
      _CandidateDonor(
        id: 'other_area_newer',
        bloodType: 'A+',
        area: 'Piassa',
        isAvailable: true,
        updatedAt: DateTime(2026, 11, 27, 15, 0),
      ),
      _CandidateDonor(
        id: 'same_area_older',
        bloodType: 'A+',
        area: 'Bole',
        isAvailable: true,
        updatedAt: DateTime(2026, 11, 27, 10, 0),
      ),
      _CandidateDonor(
        id: 'same_area_newest',
        bloodType: 'A+',
        area: 'Bole',
        isAvailable: true,
        updatedAt: DateTime(2026, 11, 27, 14, 0),
      ),
    ];

    final ranked = rankMatchingDonors(
      donors: donors,
      neededBloodType: 'A+',
      targetArea: 'Bole',
    );

    expect(ranked.map((d) => d.id).toList(), [
      'same_area_newest',
      'same_area_older',
      'other_area_newer',
    ]);
  });
}