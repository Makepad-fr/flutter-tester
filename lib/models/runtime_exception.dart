class RuntimeException implements Exception {
  late String _message;

  RuntimeException(
      {String? executable, required List<String?> arguments, String? stderr}) {
    _message = '$executable ${arguments.join(" ")} returned $stderr';
  }

  @override
  String toString() {
    return _message;
  }
}
