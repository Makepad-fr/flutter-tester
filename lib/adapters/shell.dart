import 'dart:io';

String? run(String executable, List<String> arguments) {
  var process = Process.runSync(executable, arguments);
  if (process.exitCode == 0) {
    return process.stdout;
  } else {
    return process.stderr;
  }
}
