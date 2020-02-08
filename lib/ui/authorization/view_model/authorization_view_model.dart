import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:sqflite_worker/model/authorization_type.dart';
import 'package:sqflite_worker/model/module.dart';
import 'package:sqflite_worker/ui/authorization/module.dart';

class AuthorizationViewModel implements AuthorizationViewModelType {
  @override
  AuthorizationType get authorizationType => _authorizationType;

  @override
  String get textAuthorizationButton => _textAuthorizationButton;

  @override
  String get textNavigationLabel => _textNavigationLabel;

  @override
  bool get isSignUpScreen => _authorizationType == AuthorizationType.signUp;

  @override
  String get titleScreen => _titleScreen;

  final Injector _injector;
  final AuthorizationType _authorizationType;
  String _textAuthorizationButton;
  String _textNavigationLabel;
  String _titleScreen;

  AuthorizationViewModel(this._injector, this._authorizationType) {
    if (_authorizationType == AuthorizationType.signIn) {
      this._textAuthorizationButton = "Sign in";
      this._textNavigationLabel = "Sign up";
      this._titleScreen = "Sign in";
    } else {
      this._textAuthorizationButton = "Sign up";
      this._textNavigationLabel = "Sign in";
      this._titleScreen = "Sign up";
    }
  }

  @override
  void initState() {}

  @override
  void onClickAuthorization() {
    if(_authorizationType == AuthorizationType.signIn) {
      print("click on sign in");
    } else {
      print("click on sign up");
    }
  }

  @override
  void onClickNavigation(BuildContext context) {
    AuthorizationViewModelType authorizationViewModel;
    if (authorizationType == AuthorizationType.signIn) {
      authorizationViewModel =
          AuthorizationViewModel(_injector, AuthorizationType.signUp);
    } else {
      authorizationViewModel =
          AuthorizationViewModel(_injector, AuthorizationType.signIn);
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => AuthorizationPage(authorizationViewModel)));
  }


}
