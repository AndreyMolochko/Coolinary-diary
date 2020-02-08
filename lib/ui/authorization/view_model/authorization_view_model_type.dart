import 'package:flutter/material.dart';
import 'package:sqflite_worker/model/module.dart';

abstract class AuthorizationViewModelType {
  AuthorizationType get authorizationType;
  String get titleScreen;
  String get textAuthorizationButton;
  String get textNavigationLabel;

  bool get isSignUpScreen;

  void initState();

  void onClickAuthorization();

  void onClickNavigation(BuildContext context);
}
