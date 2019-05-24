import 'package:flutter/material.dart';
import 'package:sqflite_worker/localization/app_translations.dart';
import 'package:sqflite_worker/model/settings.dart';
import 'package:sqflite_worker/repository/settings.dart';

import '../applications.dart';

class SettingsWidget extends StatefulWidget {
  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  SettingsRepository _settingsRepository = new SettingsRepository();
  int _radioLanguage = 0;

  @override
  void initState() {
    super.initState();

    _initValueRadio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: new Text(
          AppTranslations.translate(context, "settings"),
        )),
        body: Column(
          children: <Widget>[
            ExpansionTile(
              title: Padding(
                padding: const EdgeInsets.only(left: 16, top: 8),
                child: new Text(
                    AppTranslations.translate(context,
                        _settingsRepository.settingsItemsList[0].titleIdJson),
                    style: new TextStyle(fontSize: 24.0)),
              ),
              children: <Widget>[
                Row(children: <Widget>[
                  new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _getSubitems(
                          _settingsRepository.settingsItemsList[0])),
                ]),
              ],
            )
          ],
        ));
  }

  void _handleRadioValueChange(int value) {
    _radioLanguage = value;

    setState(() {
      switch (_radioLanguage) {
        case 0:
          application
              .onLocaleChanged(Locale(application.supportedLanguagesCodes[0]));
          AppTranslations.saveCurrentLanguage(
              application.supportedLanguagesCodes[0]);
          break;
        case 1:
          application
              .onLocaleChanged(Locale(application.supportedLanguagesCodes[1]));
          AppTranslations.saveCurrentLanguage(
              application.supportedLanguagesCodes[1]);
          break;
        case 2:
          application
              .onLocaleChanged(Locale(application.supportedLanguagesCodes[2]));
          AppTranslations.saveCurrentLanguage(
              application.supportedLanguagesCodes[2]);
          break;
      }
    });
  }

  _getSubitems(SettingsItem settingsItem) {
    List<Widget> answers = new List();

    for (int i = 0; i < settingsItem.subItem.length; i++) {
      answers.add(Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 8.0),
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.only(right:16.0),
            child: Row(
              children: <Widget>[
                new Radio(
                  value: i,
                  groupValue: _radioLanguage,
                  onChanged: _handleRadioValueChange,
                ),
                new Text(
                  settingsItem.subItem[i],
                  style: new TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
          onTap: _onClickLanguage(i),
        ),
      ));
    }

    return answers;
  }

  _onClickLanguage(int i) {
    //_handleRadioValueChange(i);
  }

  void _initValueRadio() {
    AppTranslations.getCurrentLanguage().then((currentLanguage) {
      switch (currentLanguage) {
        case "en":
          _radioLanguage = 0;
          break;
        case "ru":
          _radioLanguage = 1;
          break;
        case "be":
          _radioLanguage = 2;
          break;
      }
      _handleRadioValueChange(_radioLanguage);
    });
  }
}
