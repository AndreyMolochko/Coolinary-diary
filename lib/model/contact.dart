import 'package:sqflite_worker/model/module.dart';

class Contact implements SettingsItem {
  @override
  List subItems;

  @override
  String title;

  Contact(this.subItems, this.title);
}
