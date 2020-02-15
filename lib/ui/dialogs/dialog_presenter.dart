import 'package:flutter/material.dart';

import 'module.dart';

class DialogPresenter implements DialogPresenterType {
  final String _title;
  final String _message;

  DialogPresenter(this._title, this._message);

  @override
  void show(BuildContext context) {
    FlatButton okButton = FlatButton(child: Text("Ok".toUpperCase()),onPressed: () {
      Navigator.of(context).pop();
    });
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(_title),
            content: Text(_message),
            actions: <Widget>[okButton],
          );
        });
  }
}
