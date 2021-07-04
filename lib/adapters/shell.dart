import 'dart:io';

import 'package:ft/models/runtime_exception.dart';

String? run(String executable, List<String> arguments) {
  var process = Process.runSync(executable, arguments);
  if (process.exitCode == 0) {
    return process.stdout;
  } else {
    throw RuntimeException(
        executable: executable, arguments: arguments, stderr: process.stderr);
  }
}
