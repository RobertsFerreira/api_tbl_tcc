abstract class GenericError {
  final String message;
  final String method;
  final int statusCode;

  GenericError({
    required this.message,
    required this.method,
    required this.statusCode,
  });
}
