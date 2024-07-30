class ParsingError implements Exception {
  final String message;
  ParsingError(this.message);

  @override
  String toString() => 'ParsingError: $message';
}
