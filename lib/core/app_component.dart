import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sqflite_worker/core/app_provider.dart';
import 'package:sqflite_worker/core/application/culinary_diary.dart';
import 'package:sqflite_worker/localization/app_translations.dart';
import 'package:sqflite_worker/localization/app_translations_delegate.dart';

import '../applications.dart';

class AppComponent extends StatefulWidget {
  final CulinaryDiary _application;

  AppComponent(this._application);

  @override
  _AppComponentState createState() => _AppComponentState(_application);
}

class _AppComponentState extends State<AppComponent> {
  AppTranslationsDelegate _newLocaleDelegate;
  final CulinaryDiary _application;

  _AppComponentState(this._application);

  @override
  void initState() {
    Firebase.initializeApp();
    _setLanguageIfNeed();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = _onLocaleChange;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _runApp(widget._application.firstWidget);
  }

  @override
  void dispose() {
    widget._application.onTerminate();
    super.dispose();
  }

  AppProvider _runApp(Widget widget) {
    final app = MaterialApp(
      title: 'Culinary Diary',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: widget,
      localizationsDelegates: [
        _newLocaleDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: application.supportedLocales()
    );
    return AppProvider(app, _application);
  }

  void _onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }

  void _setLanguageIfNeed() {
    AppTranslations.getCurrentLanguage().then((currentLanguage) {
      application.onLocaleChanged(Locale(currentLanguage));
    });
  }
}
