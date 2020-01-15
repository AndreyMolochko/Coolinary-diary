
import 'package:flutter/src/widgets/framework.dart';
import 'package:injector/injector.dart';

import 'package:sqflite_worker/core/app_component.dart';
import 'package:sqflite_worker/core/session/session.dart';
import 'package:sqflite_worker/ui/guide/module.dart';

import 'application.dart';

class CulinaryDiary implements Application{

  final Injector _injector;

  CulinaryDiary(this._injector);

  @override
  AppComponent appComponent;

  @override
  Widget firstWidget;

  @override
  void onCreate() {
    Session session = Session();
    session.registerDependencies(_injector);
    firstWidget = GuidePage();
    appComponent = AppComponent(this);

  }

  @override
  void onTerminate() {

  }

}