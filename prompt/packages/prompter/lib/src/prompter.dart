import 'option.dart';
import 'terminal.dart';

const _terminal = Terminal();

class Prompter {
  dynamic askMultiple(String prompt, List<Option> options) {
    _terminal.clearScreen();
    _terminal.prompt(prompt);
    _terminal.printOptions(options);
    final input = _terminal.collectInput();
    final value = int.tryParse(input);
    if (value == null) return askMultiple(prompt, options);
    return options[value].value;
  }

  dynamic askBinary(String prompt) {
    _terminal.clearScreen();
    _terminal.prompt('$prompt (y/n)');
    final input = _terminal.collectInput();
    return input.contains('y');
  }

  void clear() {
    _terminal.clearScreen();
  }
}
