import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_worker/localization/app_translations.dart';
import 'package:sqflite_worker/model/module.dart';

import '../applications.dart';
import 'module.dart';

class LocaleProvider implements LocaleProviderType {
  @override
  void onLocaleChanges(LanguageType languageType) {
    application
        .onLocaleChanged(Locale(getLocaleCodeByLanguageType(languageType)));
  }

  @override
  void saveLocale(LanguageType languageType) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(
        'languageCode', getLocaleCodeByLanguageType(languageType));
  }

  @override
  Future<String> getLocale() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String localeCode = sharedPreferences.getString('languageCode');
    if (localeCode == null) {
      return AppTranslations.englishLanguage;
    } else {
      return localeCode;
    }
  }

  @override
  LanguageType getLanguageTypeByLocaleCode(String localeCode) {
    switch (localeCode) {
      case AppTranslations.englishLanguage:
        return LanguageType.English;
      case AppTranslations.russianLanguage:
        return LanguageType.Russian;
      case AppTranslations.belarussianLanguage:
        return LanguageType.Belarussian;
    }
  }

  @override
  String getLocaleCodeByLanguageType(LanguageType languageType) {
    switch (languageType) {
      case LanguageType.English:
        return AppTranslations.englishLanguage;
      case LanguageType.Russian:
        return AppTranslations.russianLanguage;
      case LanguageType.Belarussian:
        return AppTranslations.belarussianLanguage;
    }
  }
}
