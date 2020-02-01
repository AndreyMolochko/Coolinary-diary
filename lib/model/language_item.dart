import 'module.dart';

class LanguageItem implements SettingsItem {
  @override
  List<dynamic> subItems;

  @override
  String title;

  LanguageItem(this.title, this.subItems);
}
