import 'package:flutter/material.dart';
import 'package:sqflite_worker/model/module.dart';

import '../applications.dart';
import 'module.dart';

class LocaleProvider implements LocaleProviderType {
  @override
  void onLocaleChanges(LanguageType languageType) {
    switch (languageType) {
      case LanguageType.English:
        application.onLocaleChanged(
            Locale(application.supportedLanguagesCodes[0]));
        break;
      case LanguageType.Russian:
        application.onLocaleChanged(
            Locale(application.supportedLanguagesCodes[1]));
        break;
      case LanguageType.Belarussian:
        application.onLocaleChanged(
            Locale(application.supportedLanguagesCodes[2]));
        break;
    }
  }
}
