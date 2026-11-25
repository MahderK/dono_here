import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'request_response.freezed.dart';

@freezed
abstract class RequestResponse with _$RequestResponse {
  const factory RequestResponse({
    required String id,
    required String requestId,
    required String donorId,
    required ResponseStatus status,
    required DateTime createdAt,
  }) = _RequestResponse;
}
