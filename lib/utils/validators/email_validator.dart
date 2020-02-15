import 'package:sqflite_worker/utils/validators/validators.dart';

class EmailValidator implements EmailValidatorType {
  @override
  bool isEmailValid(String email) {
    return email.isNotEmpty;
  }
}