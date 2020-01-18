import 'package:injector/src/injector_base.dart';
import 'package:sqflite_worker/core/session/session_type.dart';
import 'package:sqflite_worker/providers/module.dart';

class Session implements SessionType {
  @override
  void registerDependencies(Injector injector) {
    injector.registerSingleton<SharedPreferencesProviderType>(
        (_) => SharedPreferencesProvider());
  }
}
