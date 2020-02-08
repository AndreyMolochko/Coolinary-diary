import 'package:flutter/src/widgets/framework.dart';
import 'package:injector/injector.dart';

import 'package:sqflite_worker/core/app_component.dart';
import 'package:sqflite_worker/core/session/session.dart';
import 'package:sqflite_worker/model/module.dart';
import 'package:sqflite_worker/providers/module.dart';
import 'package:sqflite_worker/screens/dish_list.dart';
import 'package:sqflite_worker/ui/authorization/module.dart';
import 'package:sqflite_worker/ui/dish_list/module.dart';
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

  @override
  void onCreate() async {
    Session session = Session();
    session.registerDependencies(_injector);
    SharedPreferencesProviderType sharedPreferencesProviderType =
        _injector.getDependency<SharedPreferencesProviderType>();

    bool isShowingGuidePage;
    await sharedPreferencesProviderType.getShowingGuidePage().then((onValue) {
      isShowingGuidePage = onValue;
      }
    );

    if (!isShowingGuidePage) {
      firstWidget = GuidePage(GuideViewModel(_injector));
    } else {
      firstWidget = AuthorizationPage(AuthorizationViewModel(_injector, AuthorizationType.signIn));
    }

    appComponent = AppComponent(this);
  }

  @override
  void onTerminate() {}
}
