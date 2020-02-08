import 'package:flutter/material.dart';
import 'package:sqflite_worker/model/module.dart';

abstract class AuthorizationViewModelType {
  AuthorizationType get authorizationType;
  String get textAuthorizationButton;
  String get textNavigationLabel;

  bool get isSignUpScreen;

  void initState();

  void onClickSignUp();

  void onClickSignIn();

  void onClickNavigation(BuildContext context);
}
