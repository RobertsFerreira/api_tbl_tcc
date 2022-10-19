import '../generic_error/generic_error.dart';

class InvalidArgumentHasura extends GenericError {
  final String key;

  InvalidArgumentHasura({
    required super.message,
    required this.key,
  });
}
