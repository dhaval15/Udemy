import 'dart:async';

mixin ValidatorMixin {
  StreamTransformer<String, String> validateEmail =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if (email.contains('@'))
        sink.add(email);
      else
        sink.addError('Enter Valid Email');
    },
  );

  StreamTransformer<String, String> validatePassword =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length > 3)
        sink.add(password);
      else
        sink.addError('Characters must be more than 3');
    },
  );
}
