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

  @override
  Stream<LanguageType> get radioGroupLanguage => languageRadioController.stream;

  final Injector _injector;
  MenuItemProviderType _menuItemProvider;

  final listItemsController = BehaviorSubject<List<SettingsItem>>();
  final appVersionController = BehaviorSubject<String>();
  final languageRadioController = BehaviorSubject<LanguageType>();
  PackageInfoProviderType _packageInfoProvider;

  SettingsViewModel(this._injector, this._menuItemProvider) {
    _packageInfoProvider = _injector.getDependency<PackageInfoProviderType>();
  }

  @override
  void initState() async {
    listItemsController.sink.add(_menuItemProvider.getSettingsItems());
    String _appVersion = await _packageInfoProvider.getAppVersion();
    appVersionController.sink.add(_appVersion);
    languageRadioController.sink.add(LanguageType.English);
  }

  @override
  void dispose() {
    listItemsController.close();
    appVersionController.close();
    languageRadioController.close();
  }

  @override
  void handleLanguageRadio(dynamic value) {
    languageRadioController.sink.add(value);
    switch (value) {
      case LanguageType.English:
        print("click on english");
        break;
      case LanguageType.Russian:
        print("click on russian");
        break;
      case LanguageType.Belarussian:
        print(" click on belarussian");
        break;
    }
  }

  @override
  String getLanguageByType(LanguageType languageType) {
    switch (languageType) {
      case LanguageType.English:
        return "English";
      case LanguageType.Russian:
        return "Русский";
      case LanguageType.Belarussian:
        return "Беларуская";
    }
  }
}
