import 'package:flutter/material.dart';
import 'package:sqflite_worker/core/app_component.dart';

abstract class Application {
  AppComponent appComponent;
  Widget firstWidget;

  void onCreate();

  void onTerminate();
}
