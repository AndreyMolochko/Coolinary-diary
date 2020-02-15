import 'package:sqflite_worker/model/module.dart';

abstract class ValidationStatusType {
  ValidationStatus getValidationStatus(AuthorizationType authorizationType,
      String login, String password, {String repeatedPassword});
}