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

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _repeatedPasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget._authorizationViewModel.titleScreen)),
      body: _buildBody(),
      backgroundColor: App.Colors.white,);
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        _buildEmailTextField(),
        _buildPasswordTextField(),
        if(widget._authorizationViewModel.isSignUpScreen)
          _buildRepeatedPasswordTextField(),
        _buildAuthorizationButton(context),
        _buildNavigationText(context),
      ],
    );
  }

  Widget _buildEmailTextField() {
    return Padding(
      padding: const EdgeInsets.only(
          left: App.Dimens.bigPadding,
          right: App.Dimens.bigPadding,
          bottom: App.Dimens.smallPadding),
      child: TextFormField(
        onFieldSubmitted: (value) {
          _changeFocusField(context, _emailFocusNode, _passwordFocusNode);
        },
        focusNode: _emailFocusNode,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            labelText: "Email"
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    TextInputAction textInputAction;
    if (widget._authorizationViewModel.isSignUpScreen) {
      textInputAction = TextInputAction.next;
    } else {
      textInputAction = TextInputAction.done;
    }
    return Padding(
      padding: const EdgeInsets.only(
          left: App.Dimens.bigPadding,
          right: App.Dimens.bigPadding,
          bottom: App.Dimens.smallPadding),
      child: TextFormField(
        onFieldSubmitted: (value) {
          if (widget._authorizationViewModel.isSignUpScreen) {
            _changeFocusField(
                context, _passwordFocusNode, _repeatedPasswordFocusNode);
          } else {
            widget._authorizationViewModel.onClickAuthorization(context);
          }
        },
        focusNode: _passwordFocusNode,
        textInputAction: textInputAction,
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
        onFieldSubmitted: (value) {
          widget._authorizationViewModel.onClickAuthorization(context);
        },
        focusNode: _repeatedPasswordFocusNode,
        textInputAction: TextInputAction.done,
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
            widget._authorizationViewModel.onClickAuthorization(context);
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

  void _changeFocusField(BuildContext context, FocusNode currentFocusNode, FocusNode nextFocusNode) {
    FocusScope.of(context).requestFocus(nextFocusNode);
  }
}
