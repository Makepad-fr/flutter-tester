import 'dart:async';
import 'dart:io';

import 'package:ft/adapters/shell.dart';
import 'package:ft/models/platform.dart';

class Simulator {
  final Platform platform;
  final String os;
  final List<String> permissions;
  final bool headless;
  final String name;
  final String deviceIdentifier;
  late String _id;

  Simulator(
      {required this.platform,
      required this.os,
      required this.deviceIdentifier,
      required this.permissions,
      required this.headless,
      required this.name}) {
    _id = platform.prepareApp(deviceIdentifier, os, permissions, headless, name,
        platform.getBundleName());
  }

  void runTests(String fileName, bool record) {
    final rp = Completer();
    if (record) {
      Process.run('xcrun',
          ['simctl', 'io', 'booted', 'recordVideo', '--codec=h264', ' ']);
      rp.future;
      ProcessSignal.sigint.watch().listen((signal) {
        rp.complete('Movie recording completed');
      });
    }
    run('flutter', ['test', '-d', _id, '--pub', fileName]);
    if (record) {
      rp.complete('Movie recording completed');
    }
  }

  void cleanUp() {
    return platform.cleanUp(_id);
  }
}
