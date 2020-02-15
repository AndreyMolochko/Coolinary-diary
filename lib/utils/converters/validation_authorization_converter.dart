import 'package:flutter/material.dart';
import 'package:sqflite_worker/model/validation_status_authorization.dart';
import 'package:sqflite_worker/utils/converters/converters.dart';

class ValidationAuthorizationConverter
    implements ValidationAuthorizationConverterType {
  @override
  String getErrorMessage(
      BuildContext context, ValidationStatus validationStatus) {
    switch (validationStatus) {
      case ValidationStatus.EmailIsEmpty:
        return "The email field should not be empty";
      case ValidationStatus.PasswordIsEmpty:
        return "The password field should not be empty";
      case ValidationStatus.PasswordsArentEquals:
        return "The password fields should be equal";
      case ValidationStatus.Unknown:
        return "Uknown error :(";
      case ValidationStatus.Ok:
        return "Ok";
    }
  }
}
