import 'package:sqflite_worker/model/module.dart';

abstract class MenuItemProviderType {
  List<SettingsItem> getSettingsItems();
}