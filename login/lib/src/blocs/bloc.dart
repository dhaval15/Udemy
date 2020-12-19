import 'package:rxdart/rxdart.dart';

import '../mixins/validator_mixin.dart';

class Bloc with ValidatorMixin {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<bool> get submit =>
      Rx.combineLatest2(email, password, (email, password) => true);

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  void login() {
    print('Email Id : ${_email.value}');
    print('Password : ${_password.value}');
  }

  void dispose() {
    _email.close();
    _password.close();
  }
}
