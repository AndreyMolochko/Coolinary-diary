import 'package:sqflite_worker/model/module.dart';

abstract class ValidationStatusAuthorizationType {
  ValidationStatus getValidationStatus(AuthorizationType authorizationType,
      String email, String password, {String repeatedPassword});
}