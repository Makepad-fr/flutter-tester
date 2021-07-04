class PathDoesNotExistsException implements Exception {
  late String _message;

  PathDoesNotExistsException(String? path) {
    _message = '$path does not exists';
  }

  @override
  String toString() {
    return _message;
  }
}
