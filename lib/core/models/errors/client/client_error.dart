import '../generic_error/generic_error.dart';

class ClientError extends GenericError {
  ClientError({
    required super.message,
    required super.method,
    required super.statusCode,
  });
}
