import 'package:injector/injector.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqflite_worker/model/module.dart';
import 'package:sqflite_worker/providers/menu_item_provider_type.dart';
import 'package:sqflite_worker/providers/module.dart';

import '../module.dart';

class SettingsViewModel implements SettingsViewModelType {
  @override
  Stream<List<SettingsItem>> get items => listItemsController.stream;

  @override
  Stream<String> get appVersion => appVersionController.stream;

  final Injector _injector;
  MenuItemProviderType _menuItemProvider;

  final listItemsController = BehaviorSubject<List<SettingsItem>>();
  final appVersionController = BehaviorSubject<String>();
  PackageInfoProviderType _packageInfoProvider;

  SettingsViewModel(this._injector, this._menuItemProvider) {
    _packageInfoProvider = _injector.getDependency<PackageInfoProviderType>();
  }

  @override
  void initState() async {
    listItemsController.sink.add(_menuItemProvider.getSettingsItems());
    String _appVersion = await _packageInfoProvider.getAppVersion();
    appVersionController.sink.add(_appVersion);
  }

  @override
  void dispose() {
    listItemsController.close();
    appVersionController.close();
  }
}
