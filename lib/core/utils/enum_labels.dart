import '../../domain/models/enums.dart';

/// Human-readable labels for enums, shared by all screens.
extension BloodTypeLabel on BloodType {
  String get label => switch (this) {
    BloodType.aPositive => 'A+',
    BloodType.aNegative => 'A-',
    BloodType.bPositive => 'B+',
    BloodType.bNegative => 'B-',
    BloodType.abPositive => 'AB+',
    BloodType.abNegative => 'AB-',
    BloodType.oPositive => 'O+',
    BloodType.oNegative => 'O-',
  };
}

extension RequestUrgencyLabel on RequestUrgency {
  String get label => switch (this) {
    RequestUrgency.low => 'Low',
    RequestUrgency.medium => 'Medium',
    RequestUrgency.critical => 'Critical',
  };
}
