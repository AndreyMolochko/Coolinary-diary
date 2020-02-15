import 'package:sqflite_worker/model/module.dart';

class LogoutItem implements SettingsItem {
  @override
  List subItems;

  @override
  String title;

  LogoutItem(this.title, this.subItems);
}
