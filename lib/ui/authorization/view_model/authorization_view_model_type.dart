import 'package:flutter/material.dart';
import 'package:sqflite_worker/model/module.dart';

abstract class AuthorizationViewModelType {
  AuthorizationType get authorizationType;
  String get textAuthorizationButton;
  String get textNavigationLabel;

  void initState();

  void onClickSignUp();

  void onClickSignIn();

  void onClickNavigation(BuildContext context);
}
