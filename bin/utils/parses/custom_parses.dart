extension ParserExtension on String {
  toParse(Type type) {
    switch (type) {
      case int:
        return int.parse(this);
      case double:
        return double.parse(this);
      case String:
        return toString();
      default:
        return toString();
    }
  }
}
