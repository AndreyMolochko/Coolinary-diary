import 'package:flutter/material.dart';
import 'package:sqflite_worker/model/module.dart';

abstract class AuthorizationViewModelType {
  Stream<bool> get isLoading;
  AuthorizationType get authorizationType;
  String get titleScreen;
  String get textAuthorizationButton;
  String get textNavigationLabel;

  bool get isSignUpScreen;

  void initState();

  void dispose();

  void onClickAuthorization(String email, String password, String repeatedPassword, BuildContext context);

  void onClickNavigation(BuildContext context);
}
