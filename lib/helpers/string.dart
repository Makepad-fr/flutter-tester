final RegExp bundleRegexp = RegExp(r'\w+\.\w+\.\w+');
final RegExp environmentVariableRegexp = RegExp(r'\$\(([A-Z_]+)\)');
bool _hasRegExpMatch(String input, RegExp r) {
  return r.hasMatch(input);
}

bool isBundleIdentifier(String input) {
  return _hasRegExpMatch(input, bundleRegexp);
}

bool isEnvironmentVariable(String input) {
  return _hasRegExpMatch(input, environmentVariableRegexp);
}

String? getEnvironmentVariableName(String environmentVariableString) {
  var match = environmentVariableRegexp.firstMatch(environmentVariableString)!;
  return match.group(1);
}
