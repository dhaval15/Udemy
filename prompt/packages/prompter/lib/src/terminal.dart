import 'dart:io';

import 'option.dart';

class Terminal {
  const Terminal();

  void clearScreen() {
    if (Platform.isWindows) {
      stdout.write('\x1B[2J\x1B[0f');
    } else {
      stdout.write('\x1B[2J\x1B[3J\x1B[H');
    }
  }

  void prompt(String prompt) {
    stdout.writeln(prompt);
  }

  void printOptions(List<Option> options) {
    options.asMap().forEach((index, value) {
      stdout.writeln('$index)  ${value.label}');
    });
  }

  String collectInput() {
    stdout.writeln('');
    stdout.write('>');
    return stdin.readLineSync();
  }
}
