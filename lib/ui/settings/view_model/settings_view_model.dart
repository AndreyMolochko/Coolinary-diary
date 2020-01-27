import 'package:injector/injector.dart';

import '../module.dart';

class SettingsViewModel implements SettingsViewModelType {
  final Injector _injector;

  SettingsViewModel(this._injector);

}