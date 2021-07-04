import 'package:ft/models/platform.dart';

class PlatformNotImplementedException implements Exception {
  late String _message;
  PlatformNotImplementedException(Platform platform) {
    _message = '$platform not yet implemented';
  }
  @override
  String toString() {
    return _message;
  }
}
