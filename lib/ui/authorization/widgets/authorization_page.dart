import 'package:flutter/material.dart';
import 'package:sqflite_worker/ui/authorization/module.dart';

class AuthorizationPage extends StatefulWidget {

  final AuthorizationViewModelType authorizationViewModel;

  AuthorizationPage(this.authorizationViewModel);
  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
