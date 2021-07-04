import 'dart:convert';
import 'dart:io';

import 'package:ft/adapters/console.dart';
import 'package:ft/adapters/fs.dart';
import 'package:ft/adapters/shell.dart';
import 'package:ft/helpers/string.dart';

final Map<String, String> iphoneTypes = {
  '4s': 'com.apple.CoreSimulator.SimDeviceType.iPhone-4s',
  '5': 'com.apple.CoreSimulator.SimDeviceType.iPhone-5',
  '5s': 'com.apple.CoreSimulator.SimDeviceType.iPhone-5s',
  '6 plus': 'com.apple.CoreSimulator.SimDeviceType.iPhone-6-Plus',
  '6': 'com.apple.CoreSimulator.SimDeviceType.iPhone-6',
  '6s': 'com.apple.CoreSimulator.SimDeviceType.iPhone-6s',
  '6s plus': 'com.apple.CoreSimulator.SimDeviceType.iPhone-6s-Plus',
  'se': 'com.apple.CoreSimulator.SimDeviceType.iPhone-SE',
  '7': 'com.apple.CoreSimulator.SimDeviceType.iPhone-7',
  '7 plus': 'com.apple.CoreSimulator.SimDeviceType.iPhone-7-Plus',
  '8': 'com.apple.CoreSimulator.SimDeviceType.iPhone-8',
  '8 plus': 'com.apple.CoreSimulator.SimDeviceType.iPhone-8-Plus',
  'x': 'com.apple.CoreSimulator.SimDeviceType.iPhone-X',
  'xs': 'com.apple.CoreSimulator.SimDeviceType.iPhone-XS',
  'xs max': 'com.apple.CoreSimulator.SimDeviceType.iPhone-XS-Max',
  'xr': 'com.apple.CoreSimulator.SimDeviceType.iPhone-XR',
  '11': 'com.apple.CoreSimulator.SimDeviceType.iPhone-11',
  '11 pro': 'com.apple.CoreSimulator.SimDeviceType.iPhone-11-Pro',
  '11 pro max': 'com.apple.CoreSimulator.SimDeviceType.iPhone-11-Pro-Max',
  'iPhone 12 mini': 'com.apple.CoreSimulator.SimDeviceType.iPhone-12-mini',
  'iPhone 12': 'com.apple.CoreSimulator.SimDeviceType.iPhone-12',
  'iPhone 12 Pro': 'com.apple.CoreSimulator.SimDeviceType.iPhone-12-Pro',
  'iPhone 12 Pro Max':
      'com.apple.CoreSimulator.SimDeviceType.iPhone-12-Pro-Max',
  'se 2nd gen':
      'com.apple.CoreSimulator.SimDeviceType.iPhone-SE--2nd-generation-'
};
final Map<String, String> ipadTypes = {
  '2': 'com.apple.CoreSimulator.SimDeviceType.iPad-2',
  'retina': 'com.apple.CoreSimulator.SimDeviceType.iPad-Retina',
  'air': 'com.apple.CoreSimulator.SimDeviceType.iPad-Air',
  'mini 2': 'com.apple.CoreSimulator.SimDeviceType.iPad-mini-2',
  'mini 3': 'com.apple.CoreSimulator.SimDeviceType.iPad-mini-3',
  'mini 4': 'com.apple.CoreSimulator.SimDeviceType.iPad-mini-4',
  'air 2': 'com.apple.CoreSimulator.SimDeviceType.iPad-Air-2',
  'pro 9.7': 'com.apple.CoreSimulator.SimDeviceType.iPad-Pro--9-7-inch-',
  'pro 12.9': 'com.apple.CoreSimulator.SimDeviceType.iPad-Pro',
  '5th gen': 'com.apple.CoreSimulator.SimDeviceType.iPad--5th-generation-',
  'pro 12.9 2nd gen':
      'com.apple.CoreSimulator.SimDeviceType.iPad-Pro--12-9-inch---2nd-generation-',
  'pro 10.5': 'com.apple.CoreSimulator.SimDeviceType.iPad-Pro--10-5-inch-',
  '6th gen': 'com.apple.CoreSimulator.SimDeviceType.iPad--6th-generation-',
  '7th gen': 'com.apple.CoreSimulator.SimDeviceType.iPad--7th-generation-',
  '8th gen': 'com.apple.CoreSimulator.SimDeviceType.iPad--8th-generation-',
  'pro 11': 'com.apple.CoreSimulator.SimDeviceType.iPad-Pro--11-inch-',
  'pro 12.9 3rd gen':
      'com.apple.CoreSimulator.SimDeviceType.iPad-Pro--12-9-inch---3rd-generation-',
  'pro 11 2nd gen':
      'com.apple.CoreSimulator.SimDeviceType.iPad-Pro--11-inch---2nd-generation-',
  'pro 12.9 4th gen':
      'com.apple.CoreSimulator.SimDeviceType.iPad-Pro--12-9-inch---4th-generation-',
  'mini 5th gen':
      'com.apple.CoreSimulator.SimDeviceType.iPad-mini--5th-generation-',
  'air 3rd gen':
      'com.apple.CoreSimulator.SimDeviceType.iPad-Air--3rd-generation-',
};

bool checkSimulatorIdentifier(String simid) {
  return [...ipadTypes.values, ...iphoneTypes.values].contains(simid);
}

List<String> permissions = [
  'all',
  'calendar',
  'contacts-limited',
  'contacts',
  'location',
  'location-always',
  'photos-add',
  'photos',
  'media-library',
  'microphone',
  'motion',
  'reminders',
  'siri',
];

String mapIOSRuntime(String version) {
  return 'com.apple.CoreSimulator.SimRuntime.iOS-${version.replaceAll('.', '-')}';
}

final String defaultiOSRuntime = 'com.apple.CoreSimulator.SimRuntime.iOS-14-4';

String? getXCodeBuildEnvironmentVaribles(
    {String projectPath = './ios/Runner.xcodeproj'}) {
  projectPath = getAbsolutePath(projectPath);
  return run('xcodebuild', ['-project', projectPath, '-showBuildSettings']);
}

String? getXCodeBuildEnvironmentVariable(String variableName) {
  var r = RegExp(variableName + r'\s*=\s+(' + bundleRegexp.pattern + r')');
  var match = r.firstMatch(getXCodeBuildEnvironmentVaribles()!)!;
  return match.group(1);
}

/// Creates a simulator with given simulator name, device and runtime
String createSimulator({String? simulatorName, String? device}) {
  return run('xcrun', ['simctl', 'create', simulatorName!, device!])!
      .replaceAll('\n', '');
}

/// Check if the simulator is booted
bool _isSimulatorBooted(String uid) {
  return run('xcrun', ['simctl', 'list'])!
      .split('\n')
      .where((element) => element.contains('Booted') && element.contains(uid))
      .toList()
      .isNotEmpty;
}

/// Boots the simulator from the given uid
String? bootSimulator(String uid,
    {bool? headless = true,
    String simulatorAppPath =
        '/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app/'}) {
  print('Headless in bootSimulator $headless');
  var boot = run('xcrun', ['simctl', 'boot', uid]);
  while (!_isSimulatorBooted(uid)) {
    continue;
  }
  if (headless!) {
    return boot;
  }
  return run('open', [simulatorAppPath]);
}

/// Shutsdown the simulator with the given uid
String? shutdownSimulator(String? uid) {
  return run('xcrun', ['simctl', 'shutdown', uid!]);
}

/// Grant permissions to the installed app
String? grantPermission(
    {String? uid, String? bundleIndentifier, String? permission}) {
  return run('xcrun',
      ['simctl', 'privacy', uid!, 'grant', permission!, bundleIndentifier!]);
}

/// Erasing the simulator
String? eraseSimulator(String? uid) {
  return run('xcrun', ['simctl', 'erase', uid!]);
}

String? getIOSBundleName(String? bundlePath) {
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
