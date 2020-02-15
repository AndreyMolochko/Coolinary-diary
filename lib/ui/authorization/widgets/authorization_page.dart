import 'package:flutter/material.dart';
import 'package:sqflite_worker/localization/app_translations.dart';
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

  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController repeatedPasswordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppTranslations.of(context).text(
          widget._authorizationViewModel.titleScreen))),
      body: _buildBody(),
      backgroundColor: App.Colors.white,);
  }

  @override
  void dispose() {
    super.dispose();
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
        controller: emailTextController,
        onFieldSubmitted: (value) {
          _changeFocusField(context, _emailFocusNode, _passwordFocusNode);
        },
        focusNode: _emailFocusNode,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            labelText: AppTranslations.of(context).text(
                'email_label_authorization_screen')
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
        obscureText: true,
        controller: passwordTextController,
        onFieldSubmitted: (value) {
          if (widget._authorizationViewModel.isSignUpScreen) {
            _changeFocusField(
                context, _passwordFocusNode, _repeatedPasswordFocusNode);
          } else {
            widget._authorizationViewModel.onClickAuthorization(
                emailTextController.text, passwordTextController.text,
                repeatedPasswordTextController.text, context);
          }
        },
        focusNode: _passwordFocusNode,
        textInputAction: textInputAction,
        decoration: InputDecoration(
            labelText: AppTranslations.of(context).text(
                'password_label_authorization_screen')
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
        obscureText: true,
        controller: repeatedPasswordTextController,
        onFieldSubmitted: (value) {
          widget._authorizationViewModel.onClickAuthorization(
              emailTextController.text, passwordTextController.text,
              repeatedPasswordTextController.text, context);
        },
        focusNode: _repeatedPasswordFocusNode,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            labelText: AppTranslations.of(context).text(
                'password_label_authorization_screen')
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
          child: Text(AppTranslations.of(context).text(
              widget._authorizationViewModel.textAuthorizationButton),
            style: App.TextStyles.normalBlackText,),
          color: App.Colors.white,
          shape: App.Shapes.secondaryButton,
          onPressed: () {
            widget._authorizationViewModel.onClickAuthorization(
                emailTextController.text, passwordTextController.text,
                repeatedPasswordTextController.text, context);
          },),
      ),
    );
  }

  Widget _buildNavigationText(BuildContext context) {
    return Center(
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.only(bottom: App.Dimens.normalPadding),
            child: Text(AppTranslations.of(context).text(
                widget._authorizationViewModel.textNavigationLabel),
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
