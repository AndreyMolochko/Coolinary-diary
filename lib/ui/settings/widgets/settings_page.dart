import 'package:flutter/material.dart';
import 'package:sqflite_worker/ui/settings/module.dart';

class SettingsPage extends StatefulWidget {
  final SettingsViewModelType _viewModel;

  SettingsPage(this._viewModel);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: _buildBody());
  }

  Widget _buildBody() {
    return Text("Settings screen");
  }
}
