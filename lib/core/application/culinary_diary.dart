import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:sqflite_worker/core/app_component.dart';
import 'package:sqflite_worker/core/session/session.dart';
import 'package:sqflite_worker/model/module.dart';
import 'package:sqflite_worker/providers/module.dart';
import 'package:sqflite_worker/ui/authorization/module.dart';
import 'package:sqflite_worker/ui/guide/module.dart';
import 'package:sqflite_worker/ui/home/module.dart';

import 'application.dart';

class CulinaryDiary implements Application {
  final Injector _injector;

  CulinaryDiary(this._injector);

  @override
  AppComponent appComponent;

  @override
  Widget firstWidget;
  SharedPreferencesProviderType _sharedPreferencesProviderType;
  UserProviderType _userProviderType;

  @override
  void onCreate() async {
    Session session = Session();
    session.registerDependencies(_injector);
    _sharedPreferencesProviderType =
        _injector.get<SharedPreferencesProviderType>();
    _userProviderType = _injector.get<UserProviderType>();

    bool isShowingGuidePage =
        await _sharedPreferencesProviderType.getShowingGuidePage();
    String currentUserId = await _userProviderType.getCurrentUserId();

    if (!isShowingGuidePage) {
      firstWidget = GuidePage(GuideViewModel(_injector));
    } else {
      if (currentUserId.isNotEmpty) {
        firstWidget = HomePage(HomeViewModel(_injector));
      } else {
        firstWidget = AuthorizationPage(
            AuthorizationViewModel(_injector, AuthorizationType.signIn));
      }
    }

    appComponent = AppComponent(this);
  }

  @override
  void onTerminate() {}
}
