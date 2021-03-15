import 'package:injector/injector.dart';
import 'package:sqflite_worker/core/session/session_type.dart';
import 'package:sqflite_worker/providers/module.dart';
import 'package:sqflite_worker/services/module.dart';

class Session implements SessionType {
  @override
  void registerDependencies(Injector injector) {
    injector.registerSingleton<SharedPreferencesProviderType>(
        () => SharedPreferencesProvider());
    injector.registerSingleton<PackageInfoProviderType>(
        () => PackageInfoProvider());
    injector.registerSingleton<LocaleProviderType>(() => LocaleProvider());
    injector.registerSingleton<AuthorizationServiceType>(() =>
        AuthorizationService());
    injector.registerSingleton<UserProviderType>(() => UserProvider());
  }
}
