import 'package:sqflite_worker/model/module.dart';

abstract class SettingsViewModelType {
  Stream<List<SettingsItem>> get items;

  Stream<String> get appVersion;

  Stream<LanguageType> get radioGroupLanguage;

  void initState();

  void dispose();

  void handleLanguageRadio(dynamic value);

  void handleClickByNetwork(ContactResources contactResources);

  String getLanguageByType(LanguageType languageType);
}
