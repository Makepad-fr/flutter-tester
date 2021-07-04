import 'package:ansicolor/ansicolor.dart';

void success(String message, {String prefix = 'SUCCESS'}) {
  var pen = AnsiPen()..green(bold: true);
  print('${pen("$prefix:")} $message');
}

void error(String message, {String prefix = 'ERR0R'}) {
  var pen = AnsiPen()..red(bold: true);
  print('${pen("$prefix:")} $message');
}

void warning(String message, {String prefix = 'WARNING'}) {
  var pen = AnsiPen()..yellow(bold: true);
  print('${pen("$prefix:")} $message');
}

void info(String message, {String prefix = 'INFO'}) {
  var pen = AnsiPen()..blue(bold: true);
  print('${pen("$prefix:")} $message');
}
