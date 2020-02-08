import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:sqflite_worker/model/authorization_type.dart';
import 'package:sqflite_worker/model/module.dart';
import 'package:sqflite_worker/ui/authorization/module.dart';

class AuthorizationViewModel implements AuthorizationViewModelType {
  @override
  AuthorizationType get authorizationType => _authorizationType;

  final Injector _injector;
  final AuthorizationType _authorizationType;

  AuthorizationViewModel(this._injector, this._authorizationType);

  @override
  void initState() {}

  @override
  void onClickSignIn() {
    print("on click sign in");
  }

  @override
  void onClickSignUp() {
    print("on click sign up");
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
