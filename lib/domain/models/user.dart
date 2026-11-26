import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'user.freezed.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required String id,
    required String fullName,
    required String email,
    required String phoneNumber,
    required UserRole role,
    required DateTime createdAt,
  }) = _User;
}
