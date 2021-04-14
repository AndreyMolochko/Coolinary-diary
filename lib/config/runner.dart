import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:sqflite_worker/core/application/culinary_diary.dart';

void main() => Runner();

class Runner {
  Runner() {
    _run();
  }

  void _run() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    final injector = Injector();
    var application = CulinaryDiary(injector);
    await application.onCreate();
    runApp(application.appComponent);
  }
}
