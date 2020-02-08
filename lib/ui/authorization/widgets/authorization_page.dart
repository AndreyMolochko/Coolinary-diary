import 'package:flutter/material.dart';
import 'package:sqflite_worker/model/module.dart';
import 'package:sqflite_worker/resourses/module.dart' as App;
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
    return Scaffold(appBar: AppBar(), body: _buildBody(), backgroundColor: App.Colors.white,);
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        _buildAuthorizationButton(context),
        _buildNavigationText(context),
      ],
    );
  }

  Widget _buildAuthorizationButton(BuildContext context) {
    String text;
    if (widget.authorizationViewModel.authorizationType ==
        AuthorizationType.signIn) {
      text = "Sign in";
    } else {
      text = "Sign up";
    }
    return Padding(
      padding: const EdgeInsets.only(
          left: App.Dimens.bigPadding, right: App.Dimens.bigPadding, bottom: App.Dimens.smallPadding),
      child: Container(
        width: double.maxFinite,
        child: RaisedButton(
          child: Text(text, style: App.TextStyles.normalBlackText,),
          color: App.Colors.white,
          shape: App.Shapes.secondaryButton,
          onPressed: () {

          },),
      ),
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
        padding: const EdgeInsets.only(bottom: App.Dimens.normalPadding),
        child: Text(text, style: App.TextStyles.normalBlackText),
      ),
      onTap: () {
        widget.authorizationViewModel.onClickNavigation(context);
      },
    ));
  }
}
