import 'package:injector/injector.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqflite_worker/model/module.dart';
import 'package:sqflite_worker/providers/menu_item_provider_type.dart';

import '../module.dart';

class SettingsViewModel implements SettingsViewModelType {
  final listItems = BehaviorSubject<List<SettingsItem>>();

  @override
  Stream<List<SettingsItem>> get items => listItems.stream;

  final Injector _injector;
  MenuItemProviderType _menuItemProvider;

  SettingsViewModel(this._injector, this._menuItemProvider);

  @override
  void initState() {
    listItems.sink.add(_menuItemProvider.getSettingsItems());
  }

  @override
  void dispose() {
    listItems.close();
  }
}
