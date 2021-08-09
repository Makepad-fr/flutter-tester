import 'dart:io';

import 'package:ft/adapters/fs.dart';
import 'package:ft/adapters/xcode.dart' as xcode;
import 'package:ft/adapters/xcode.dart';
import 'package:ft/models/path_does_not_exists_exception.dart';
import 'package:ft/models/platform_not_implemented_exception.dart';

enum Platform { ios, android, web, macos, windows, linux, fuchsia }

extension StringParser on String {
  Platform parseToPlatform() {
    switch (toLowerCase().trim()) {
      case 'ios':
        return Platform.ios;
      case 'android':
        return Platform.android;
      case 'macos':
        return Platform.macos;
      case 'windows':
        return Platform.windows;
      case 'linux':
        return Platform.linux;
      case 'fuchsia':
        return Platform.fuchsia;
      default:
        throw FormatException('$this is not a valid platform name');
    }
  }
}

extension Verifier on Platform {
  bool verifyPermission(String permission) {
    switch (this) {
      case Platform.ios:
        return xcode.permissions.contains(permission);
      default:
        throw PlatformNotImplementedException(this);
    }
  }

  bool checkDeviceIdentifier(String simulatorName) {
    switch (this) {
      case Platform.ios:
        return xcode.checkSimulatorIdentifier(simulatorName);
      default:
        throw PlatformNotImplementedException(this);
    }
  }

  String prepareApp(String deviceName, String os, List<String> permissions,
      bool headless, String simulatorName, String bundleIdentifier) {
    switch (this) {
      case Platform.ios:
        final simulatorUid =
            createSimulator(simulatorName: simulatorName, device: deviceName);
        bootSimulator(simulatorUid, headless: headless);
        for (var permission in permissions) {
          grantPermission(
              uid: simulatorUid,
              bundleIndentifier: bundleIdentifier,
              permission: permission);
        }
        return simulatorUid;
      default:
        throw PlatformNotImplementedException(this);
    }
  }

  void cleanUp(String simulatorUid) {
    shutdownSimulator(simulatorUid);
    eraseSimulator(simulatorUid);
  }

  String getDefaultRuntime() {
    switch (this) {
      case Platform.ios:
        return xcode.defaultiOSRuntime;
      default:
        throw PlatformNotImplementedException(this);
    }
  }

  String getBundleName() {
    String? bundlePath;
    switch (this) {
      case Platform.ios:
        bundlePath = 'ios/Runner/Info.plist';
        if (!File(bundlePath).existsSync()) {
          bundlePath = 'ios/Runner/Info-Debug.plist';
        }
        break;
      default:
        throw PlatformNotImplementedException(this);
    }
    if (!isPathExists(bundlePath)) {
      throw PathDoesNotExistsException(bundlePath);
    }
    switch (this) {
      case Platform.ios:
        return getIOSBundleName(bundlePath)!;
      default:
        throw PlatformNotImplementedException(this);
    }
  }
}
