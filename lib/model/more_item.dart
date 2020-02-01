import 'module.dart';

class AboutItem implements SettingsItem {
  AboutItem(this.title, this.subItems);

  @override
  List<String> subItems;

  @override
  String title;
}
