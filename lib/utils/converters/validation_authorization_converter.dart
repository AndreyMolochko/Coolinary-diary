import 'package:flutter/material.dart';
import 'package:sqflite_worker/localization/app_translations.dart';
import 'package:sqflite_worker/model/validation_status_authorization.dart';
import 'package:sqflite_worker/utils/converters/converters.dart';

class ValidationAuthorizationConverter
    implements ValidationAuthorizationConverterType {
  @override
  String getErrorMessage(
      BuildContext context, ValidationStatusAuthorization validationStatus) {
    switch (validationStatus) {
      case ValidationStatusAuthorization.EmailIsEmpty:
        return AppTranslations.of(context).text(
            'email_field_empty_message_login_screen');
      case ValidationStatusAuthorization.PasswordIsEmpty:
        return AppTranslations.of(context).text(
            'password_field_empty_message_login_screen');
      case ValidationStatusAuthorization.PasswordsArentEquals:
        return AppTranslations.of(context).text(
            'password_fields_not_equals_message_login_screen');
      case ValidationStatusAuthorization.Unknown:
        return AppTranslations.of(context).text('unknown_error_general_screen');
      case ValidationStatusAuthorization.Ok:
        return AppTranslations.of(context).text('ok_message_general_screen');
    }
  }
}
