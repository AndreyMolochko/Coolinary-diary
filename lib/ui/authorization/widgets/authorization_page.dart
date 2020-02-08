import 'package:flutter/material.dart';
import 'package:sqflite_worker/resourses/module.dart' as App;
import 'package:sqflite_worker/ui/authorization/module.dart';

class AuthorizationPage extends StatefulWidget {
  final AuthorizationViewModelType _authorizationViewModel;

  AuthorizationPage(this._authorizationViewModel);

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
        _buildLoginTextField(),
        _buildPasswordTextField(),
        if(widget._authorizationViewModel.isSignUpScreen)
          _buildRepeatedPasswordTextField(),        
        _buildAuthorizationButton(context),
        _buildNavigationText(context),
      ],
    );
  }

  Widget _buildLoginTextField() {
    return Padding(
      padding: const EdgeInsets.only(
          left: App.Dimens.bigPadding,
          right: App.Dimens.bigPadding,
          bottom: App.Dimens.smallPadding),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: "Login"
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return Padding(
      padding: const EdgeInsets.only(
          left: App.Dimens.bigPadding,
          right: App.Dimens.bigPadding,
          bottom: App.Dimens.smallPadding),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: "Password"
        ),
      ),
    );
  }

  Widget _buildRepeatedPasswordTextField() {
    return Padding(
      padding: const EdgeInsets.only(
          left: App.Dimens.bigPadding,
          right: App.Dimens.bigPadding,
          bottom: App.Dimens.smallPadding),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: "Password"
        ),
      ),
    );
  }

  Widget _buildAuthorizationButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: App.Dimens.bigPadding,
          right: App.Dimens.bigPadding,
          bottom: App.Dimens.smallPadding),
      child: Container(
        width: double.maxFinite,
        child: RaisedButton(
          child: Text(widget._authorizationViewModel.textAuthorizationButton,
            style: App.TextStyles.normalBlackText,),
          color: App.Colors.white,
          shape: App.Shapes.secondaryButton,
          onPressed: () {

          },),
      ),
    );
  }

  Widget _buildNavigationText(BuildContext context) {
    return Center(
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.only(bottom: App.Dimens.normalPadding),
            child: Text(widget._authorizationViewModel.textNavigationLabel,
                style: App.TextStyles.normalBlackText),
          ),
          onTap: () {
            widget._authorizationViewModel.onClickNavigation(context);
          },
        ));
  }
}
