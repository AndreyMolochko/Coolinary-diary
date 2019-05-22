import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class AppTranslations {
  static const englishLanguage = "en";
  static const russianLanguage = "ru";
  static const belarussianLanguage = "be";

  Locale locale;
  static Map<dynamic, dynamic> _localisedValues;

  AppTranslations(Locale locale) {
    this.locale = locale;
    _localisedValues = null;
  }

  static AppTranslations of(BuildContext context) {
    return Localizations.of<AppTranslations>(context, AppTranslations);
  }

  static Future<AppTranslations> load(Locale locale)async{
    AppTranslations appTranslations = new AppTranslations(locale);
    String jsonContent = await rootBundle.loadString("assets/locale/localization_${locale.languageCode}.json");
    _localisedValues = json.decode(jsonContent);

    return appTranslations;
  }

  get currentLanguage=> locale.languageCode;

  static String translate(BuildContext context, String stringId){
    return AppTranslations.of(context).text(stringId);
  }

  String text(String key) {
    return _localisedValues[key] ?? "$key not found";
  }
}
