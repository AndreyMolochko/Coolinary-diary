import 'package:sqflite_worker/model/module.dart';

abstract class SettingsViewModelType {
  Stream<List<SettingsItem>> get items;

  Stream<String> get appVersion;

  void initState();

  void dispose();
}
