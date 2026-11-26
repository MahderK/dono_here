enum UserRole { donor, requester, admin }

enum BloodType {
  aPositive,
  aNegative,
  bPositive,
  bNegative,
  abPositive,
  abNegative,
  oPositive,
  oNegative,
}

enum RequestUrgency { low, medium, critical }

enum RequestStatus { open, matched, fulfilled, cancelled }

enum ResponseStatus { pending, accepted, declined }
