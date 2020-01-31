import 'package:sqflite_worker/model/module.dart';
import 'package:sqflite_worker/providers/menu_item_provider_type.dart';

class MenuItemProvider implements MenuItemProviderType {
  @override
  List<SettingsItem> getSettingsItems() {
    List<SettingsItem> items = [];

    //TODO: localization
    items.add(LanguageItem('Language', ['English', 'Русский', 'Беларусская']));
    items.add(MoreItem('About', ['This app is 2.0.0 version']));

    return items;
  }
}
