import 'package:sqflite_worker/model/module.dart';

abstract class ValidationAuthorizationConverterType {
  String getErrorMessage(ValidationStatus validationStatus);
}