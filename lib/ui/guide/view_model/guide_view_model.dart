import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:sqflite_worker/model/module.dart';
import 'package:sqflite_worker/providers/module.dart';
import 'package:sqflite_worker/ui/authorization/module.dart';

import '../module.dart';

class GuideViewModel implements GuideViewModelType {
  final Injector _injector;
  SharedPreferencesProviderType _sharedPreferencesProvider;

  GuideViewModel(this._injector) {
    _sharedPreferencesProvider = _injector.getDependency<SharedPreferencesProviderType>();
  }

  @override
  void continueButtonAction(BuildContext context) {
    _sharedPreferencesProvider.saveShowingGuidePage(true);
    AuthorizationViewModelType authorizationViewModel = AuthorizationViewModel(_injector, AuthorizationType.signIn);
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => AuthorizationPage(authorizationViewModel)));
  }
}
