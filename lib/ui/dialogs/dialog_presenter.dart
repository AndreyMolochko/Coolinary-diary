import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'module.dart';

class DialogPresenter implements DialogPresenterType {
  final String _title;
  final String _message;

  DialogPresenter(this._title, this._message);

  @override
  void show(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(_title),
            content: Text(_message),
          );
        });
  }
}
