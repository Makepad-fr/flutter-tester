import 'dart:io';

import 'package:args/args.dart';
import 'package:ft/adapters/console.dart';
import 'package:ft/models/platform.dart' as p;
import 'package:ft/models/simulator.dart';

void run(List<String> arguments) {
  var parser = ArgParser()
    ..addFlag('headless', defaultsTo: true, negatable: true)
    ..addFlag('record', negatable: true)
    ..addOption('parallel-runs',
        defaultsTo: Platform.numberOfProcessors.toString())
    ..addOption('platform', abbr: 'p', allowed: ['ios'], mandatory: true)
    ..addMultiOption('device', abbr: 'd')
    ..addMultiOption('permission');
  try {
    final results = parser.parse(arguments);
    if ((results['device'] as List<String>).isEmpty) {
      error(
          'You need to specify at least one device on ${results["platform"]}');
      exit(1);
    }
    var p = (results['platform'] as String).parseToPlatform();
    var nep = (results['permission'] as List<String>)
        .where((perm) => !p.verifyPermission(perm));
    if (nep.isNotEmpty) {
      throw Exception('${nep.join(", ")} permissions does not exists');
    }
    for (var device in (results['device'] as List<String>)) {
      if (!p.checkDeviceIdentifier(device)) {
        throw Exception("${results['device']} does not exists on $p devices");
      }
    }

    var simulator = Simulator(
        permissions: results['permission'],
        os: p.getDefaultRuntime(),
        headless: results['headless'],
        name: 'ft-simulator',
        platform: p);
    for (var testFile in results.rest) {
      simulator.runTests(testFile, results['record']);
    }
    simulator.cleanUp();
  } on FormatException catch (e) {
    error(e.message);
  }
}
