import 'dart:convert';
import 'dart:io';

import 'package:ft/adapters/xcode.dart';
import 'package:ft/helpers/string.dart';
import 'package:ft/models/path_does_not_exists_exception.dart';
import 'package:ft/models/platform.dart';
import 'package:ft/models/platform_not_implemented_exception.dart';
import 'package:ft/adapters/console.dart';
import 'package:ft/adapters/shell.dart';
import 'package:path/path.dart' as p;

String? getWorkingDirectory() {
  return run('pwd', []);
}

String getAbsolutePath(String? path, {bool relative = true}) {
  var absolutePath = p.join(getWorkingDirectory()!, path);
  absolutePath = absolutePath.replaceAll('\n', '');
  return absolutePath;
}

bool isPathExists(String? path, {bool relative = true}) {
  var absolutePath = getAbsolutePath(path);
  var lsResult = run('ls', [absolutePath]);
  return (lsResult != null && lsResult.isNotEmpty);
}

String? _getIOSBundleName(String? bundlePath) {
  bundlePath = getAbsolutePath(bundlePath);
  info('Converting $bundlePath to JSON file');
  run('plutil', ['-convert', 'json', '-o', bundlePath + '.json', bundlePath]);
  success('$bundlePath.json file crated');
  var bundleJSONFile = File(bundlePath + '.json');
  var bundleJSON = jsonDecode(bundleJSONFile.readAsStringSync());
  var bundleIdentifier = bundleJSON['CFBundleIdentifier'];
  info('Removing the $bundlePath.json file');
  run('rm', [bundlePath + '.json']);
  success('$bundlePath.json file removed');
  if (isBundleIdentifier(bundleIdentifier)) {
    return bundleIdentifier;
  }
  if (isEnvironmentVariable(bundleIdentifier)) {
    var envVarName = getEnvironmentVariableName(bundleIdentifier)!;
    bundleIdentifier = getXCodeBuildEnvironmentVariable(envVarName);
    return bundleIdentifier;
  }
  return null;
}

String? getBundleName({Platform platform = Platform.ios}) {
  String? bundlePath;
  switch (platform) {
    case Platform.ios:
      bundlePath = 'ios/Runner/Info.plist';
      if (!File(bundlePath).existsSync()) {
        bundlePath = 'ios/Runner/Info-Debug.plist';
      }
      break;
    default:
      throw PlatformNotImplementedException(platform);
  }
  if (!isPathExists(bundlePath)) {
    throw PathDoesNotExistsException(bundlePath);
  }
  switch (platform) {
    case Platform.ios:
      return _getIOSBundleName(bundlePath);
    default:
      throw PlatformNotImplementedException(platform);
  }
}
