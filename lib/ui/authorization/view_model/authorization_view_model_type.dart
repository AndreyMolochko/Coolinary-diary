import 'package:flutter/material.dart';
import 'package:sqflite_worker/model/module.dart';

abstract class AuthorizationViewModelType {
  AuthorizationType get authorizationType;

  void initState();

  void onClickSignUp();

  void onClickSignIn();

  void onClickNavigation(BuildContext context);
}
