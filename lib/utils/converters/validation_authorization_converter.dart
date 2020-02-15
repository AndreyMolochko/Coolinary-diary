import 'package:flutter/material.dart';
import 'package:sqflite_worker/model/validation_status_authorization.dart';
import 'package:sqflite_worker/utils/converters/converters.dart';

class ValidationAuthorizationConverter
    implements ValidationAuthorizationConverterType {
  @override
  String getErrorMessage(
      BuildContext context, ValidationStatusAuthorization validationStatus) {
    switch (validationStatus) {
      case ValidationStatusAuthorization.EmailIsEmpty:
        return "The email field should not be empty";
      case ValidationStatusAuthorization.PasswordIsEmpty:
        return "The password field should not be empty";
      case ValidationStatusAuthorization.PasswordsArentEquals:
        return "The password fields should be equal";
      case ValidationStatusAuthorization.Unknown:
        return "Uknown error :(";
      case ValidationStatusAuthorization.Ok:
        return "Ok";
    }
  }
}
