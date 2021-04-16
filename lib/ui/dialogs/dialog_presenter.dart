import 'package:flutter/material.dart';
import 'package:sqflite_worker/localization/app_translations.dart';

import 'module.dart';

class DialogPresenter implements DialogPresenterType {
  final String _title;
  final String _message;
  final List<Widget> actions;

  DialogPresenter(this._title, this._message, {this.actions});

  @override
  void show(BuildContext context) {
    TextButton okButton = TextButton(child: Text(AppTranslations.translate(context, 'ok_message_general_screen').toUpperCase()),
        onPressed: () {
          Navigator.of(context).pop();
        });
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(_title),
            content: Text(_message),
            actions: actions != null ? actions : <Widget>[okButton],
          );
        });
  }
}
