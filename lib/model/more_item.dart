import 'module.dart';

class AboutItem implements SettingsItem {
  @override
  List<dynamic> subItems;

  @override
  String title;

  AboutItem(this.title, this.subItems);
}
