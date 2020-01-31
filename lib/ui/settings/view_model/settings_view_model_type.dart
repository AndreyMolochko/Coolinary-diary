import 'package:sqflite_worker/model/module.dart';

abstract class SettingsViewModelType {
  Stream<List<SettingsItem>> get items;
  void initState();
  void dispose();
}
