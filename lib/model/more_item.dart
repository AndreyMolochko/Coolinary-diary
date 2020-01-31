import 'module.dart';

class MoreItem implements SettingsItem {
  MoreItem(this.title, this.subItems);

  @override
  List<String> subItems;

  @override
  String title;
}
