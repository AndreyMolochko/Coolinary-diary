import 'package:sqflite_worker/utils/validators/validators.dart';

class PasswordValidator implements PasswordValidatorType {
  @override
  bool arePasswordsEquals(String password, String repeatedPassword) {
    return password == repeatedPassword;
  }

  @override
  bool isPasswordValid(String password) {
    return password.isNotEmpty;
  }
}
