import 'package:flutter/material.dart';
import 'package:sqflite_worker/model/module.dart';
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
    return Scaffold(appBar: AppBar(),
    body: _buildBody());
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        _buildClickableAuthorizationText(context),
      ],
    );
  }

  Widget _buildClickableAuthorizationText(BuildContext context) {
    String text;
    if (widget.authorizationViewModel.authorizationType ==
        AuthorizationType.signIn) {
      text = "Sing up";
    } else {
      text = "Sign in";
    }
    return Center(child: Text(text));
  }
}
