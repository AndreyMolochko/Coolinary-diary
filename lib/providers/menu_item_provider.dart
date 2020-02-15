import 'package:sqflite_worker/model/contact_resouces.dart';
import 'package:sqflite_worker/model/module.dart';
import 'package:sqflite_worker/providers/menu_item_provider_type.dart';

class MenuItemProvider implements MenuItemProviderType {
  @override
  List<SettingsItem> getSettingsItems() {
    List<SettingsItem> items = [];

    //TODO: localization
    items.add(LanguageItem('language_settings_screen', [LanguageType.English, LanguageType.Russian, LanguageType.Belarussian]));
    items.add(LogoutItem('logout_title_settings_screen', ['Do you want to logout?']));
    items.add(AboutItem('about_settings_screen', ['This app is 2.0.0 version']));
    //TODO: named parameters in constructor
    items.add(ContactItem('contacts_settings_screen',
        [ContactResources(ContactType.linkedin, "https://www.linkedin.com/in/andrey-molochko-27b628158", "assets/linkedin.png"),
          ContactResources(ContactType.skype, "skype:live:molochko.andrey?chat", "assets/skype.png"),
          ContactResources(ContactType.instagram, "https://www.instagram.com/molochko.andrey", "assets/instagram.png")]));

    return items;
  }
}
