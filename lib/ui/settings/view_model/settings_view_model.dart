import 'package:injector/injector.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqflite_worker/model/module.dart';
import 'package:sqflite_worker/providers/menu_item_provider_type.dart';
import 'package:sqflite_worker/providers/module.dart';
import 'package:url_launcher/url_launcher.dart';

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
  LocaleProviderType _localeProvider;

  SettingsViewModel(this._injector, this._menuItemProvider) {
    _packageInfoProvider = _injector.getDependency<PackageInfoProviderType>();
    _localeProvider = _injector.getDependency<LocaleProviderType>();
  }

  @override
  void initState() async {
    listItemsController.sink.add(_menuItemProvider.getSettingsItems());
    String _appVersion = await _packageInfoProvider.getAppVersion();
    appVersionController.sink.add(_appVersion);
    LanguageType currentLanguage = _localeProvider
        .getLanguageTypeByLocaleCode(await _localeProvider.getLocale());
    languageRadioController.add(currentLanguage);
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
    _localeProvider.onLocaleChanges(value);
    _localeProvider.saveLocale(value);
  }

  @override
  void handleClickByNetwork(ContactResources contactResources) {
    _launchSocialNetworkByUrl(contactResources.url);
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

  Future<bool> _launchSocialNetworkByUrl(String url) async {
    bool isLaunched = false;
    if (await canLaunch(url)) {
      isLaunched = await launch(url);
    }

    return isLaunched;
  }
}
