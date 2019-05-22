import 'dart:ui';

import 'localization/app_translations.dart';

class Application {
  static final Application _application = Application._internal();

  factory Application() {
    return _application;
  }

  Application._internal();

  final List<String> supportedLanguages = ["English", "Russian", "Belarussian"];

  final List<String> supportedLanguagesCodes = [
    AppTranslations.englishLanguage,
    AppTranslations.russianLanguage,
    AppTranslations.belarussianLanguage
  ];

  Iterable<Locale> supportedLocales() =>
      supportedLanguagesCodes.map<Locale>((language) => Locale(language, ""));
  LocaleChangeCallback onLocaleChanged;
}

Application application = Application();

typedef void LocaleChangeCallback(Locale locale);
