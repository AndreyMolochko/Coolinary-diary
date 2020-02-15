import 'package:sqflite_worker/model/module.dart' as Model;
import 'package:sqflite_worker/utils/validators/validators.dart';

class ValidationStatusAuthorization implements ValidationStatusAuthorizationType {
  final EmailValidatorType _emailValidator;
  final PasswordValidatorType _passwordValidator;

  ValidationStatusAuthorization(this._emailValidator, this._passwordValidator);

  @override
  Model.ValidationStatusAuthorization getValidationStatus(
      Model.AuthorizationType authorizationType, String email, String password,
      {String repeatedPassword}) {
    if (authorizationType == Model.AuthorizationType.signIn) {
      return _getSignInStatus(email, password);
    } else if (authorizationType == Model.AuthorizationType.signUp) {
      return _getSignUpStatus(email, password, repeatedPassword);
    } else {
      return Model.ValidationStatusAuthorization.Unknown;
    }
  }

  Model.ValidationStatusAuthorization _getSignInStatus(String email, String password) {
    if (!_emailValidator.isEmailValid(email)) {
      return Model.ValidationStatusAuthorization.EmailIsEmpty;
    } else if (!_passwordValidator.isPasswordValid(password)) {
      return Model.ValidationStatusAuthorization.PasswordIsEmpty;
    } else {
      return Model.ValidationStatusAuthorization.Ok;
    }
  }

  Model.ValidationStatusAuthorization _getSignUpStatus(
      String email, String password, String repeatedPassword) {
    if (!_emailValidator.isEmailValid(email)) {
      return Model.ValidationStatusAuthorization.EmailIsEmpty;
    } else if (!_passwordValidator.isPasswordValid(password)) {
      return Model.ValidationStatusAuthorization.PasswordIsEmpty;
    } else if (!_passwordValidator.arePasswordsEquals(password, repeatedPassword)) {
      return Model.ValidationStatusAuthorization.PasswordsArentEquals;
    } else {
      return Model.ValidationStatusAuthorization.Ok;
    }
  }
}
