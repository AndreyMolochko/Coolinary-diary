import 'package:sqflite_worker/model/module.dart';

abstract class LocaleProviderType {
  void onLocaleChanges(LanguageType languageType);

  void saveLocale(LanguageType languageType);

  Future<String> getLocale();

  LanguageType getLanguageTypeByLocaleCode(String localeCode);

  String getLocaleCodeByLanguageType(LanguageType languageType);
}
