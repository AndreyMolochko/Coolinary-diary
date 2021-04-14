import 'package:sqflite_worker/model/settings.dart';

class SettingsRepository {
  List<SettingsItem> settingsItemsList = new List();

  SettingsRepository() {
    settingsItemsList.add(new SettingsItem("language", ["English", "Русский", "Беларуская"]));
  }
}
