import 'module.dart';

class LanguageItem implements SettingsItem {
  LanguageItem(this.title, this.subItems);

  @override
  List<String> subItems;

  @override
  String title;
}
