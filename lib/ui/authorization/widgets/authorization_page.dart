import 'package:flutter/material.dart';
import 'package:sqflite_worker/model/module.dart';
import 'package:sqflite_worker/resourses/module.dart';
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
    return Scaffold(appBar: AppBar(), body: _buildBody());
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        _buildNavigationText(context),
      ],
    );
  }

  Widget _buildNavigationText(BuildContext context) {
    String text;
    if (widget.authorizationViewModel.authorizationType ==
        AuthorizationType.signIn) {
      text = "Sign up";
    } else {
      text = "Sign in";
    }
    return Center(
        child: InkWell(
      child: Padding(
        padding: const EdgeInsets.only(bottom: Dimens.normalPadding),
        child: Text(text, style: TextStyles.normalBlackText),
      ),
      onTap: () {
        widget.authorizationViewModel.onClickNavigation(context);
      },
    ));
  }
}
