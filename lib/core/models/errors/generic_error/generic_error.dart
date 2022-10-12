abstract class GenericError {
  final String message;

  GenericError({
    required this.message,
  });
}

class UnknownError extends GenericError {
  UnknownError({
    required super.message,
  });
}

class InvalidIdCompany extends GenericError {
  InvalidIdCompany({
    required super.message,
  });
}

class InvalidIdClass extends GenericError {
  InvalidIdClass({
    required super.message,
  });
}
