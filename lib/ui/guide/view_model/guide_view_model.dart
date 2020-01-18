import 'package:flutter/src/widgets/framework.dart';
import 'package:injector/injector.dart';
import 'package:sqflite_worker/providers/module.dart';

import '../module.dart';

class GuideViewModel implements GuideViewModelType {

  final Injector _injector;
  SharedPreferencesProviderType _sharedPreferencesProvider;

  GuideViewModel(this._injector){
    _sharedPreferencesProvider = _injector.getDependency<SharedPreferencesProviderType>();
  }

  @override
  void continueButtonAction(BuildContext context) {
    _sharedPreferencesProvider.saveShowingGuidePage(true);
  }
}
