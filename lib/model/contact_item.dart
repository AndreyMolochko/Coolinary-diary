import 'package:sqflite_worker/model/module.dart';

class ContactItem implements SettingsItem {
  @override
  List subItems;

  @override
  String title;

  ContactItem(this.title, this.subItems);
}
