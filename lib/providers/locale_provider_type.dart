import 'package:sqflite_worker/model/module.dart';

abstract class LocaleProviderType {
  void onLocaleChanges(LanguageType languageType);

  void saveLocale(LanguageType languageType);

  LanguageType getLanguageTypeByLocaleCode(String localeCode);

  String getLocaleCodeByLanguageType(LanguageType languageType);
}