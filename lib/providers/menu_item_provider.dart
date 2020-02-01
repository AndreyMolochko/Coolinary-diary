import 'package:sqflite_worker/model/module.dart';
import 'package:sqflite_worker/providers/menu_item_provider_type.dart';

class MenuItemProvider implements MenuItemProviderType {
  @override
  List<SettingsItem> getSettingsItems() {
    List<SettingsItem> items = [];

    //TODO: localization
    items.add(LanguageItem('Language', [LanguageType.English, LanguageType.Russian, LanguageType.Belarussian]));
    items.add(AboutItem('About', ['This app is 2.0.0 version']));

    return items;
  }
}
