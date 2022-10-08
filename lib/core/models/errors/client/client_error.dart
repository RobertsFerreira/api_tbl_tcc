import '../generic_error/generic_error.dart';

class ClientError extends GenericError {
  final String method;
  final int statusCode;
  ClientError({
    required super.message,
    required this.method,
    required this.statusCode,
  });
}
