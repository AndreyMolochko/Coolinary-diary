import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injector/injector.dart';
import 'package:sqflite_worker/core/session/session_type.dart';
import 'package:sqflite_worker/providers/module.dart';
import 'package:sqflite_worker/repository/dish_repository_type.dart';
import 'package:sqflite_worker/repository/repositories.dart';
import 'package:sqflite_worker/services/module.dart';

class Session implements SessionType {
  @override
  void registerDependencies(Injector injector) {
    injector.registerSingleton<SharedPreferencesProviderType>(() => SharedPreferencesProvider());
    injector.registerSingleton<PackageInfoProviderType>(() => PackageInfoProvider());
    injector.registerSingleton<LocaleProviderType>(() => LocaleProvider());
    injector.registerSingleton<AuthorizationServiceType>(() => AuthorizationService());
    injector.registerSingleton<UserProviderType>(() => UserProvider());
    injector.registerSingleton<DishRepositoryType>(
        () => DishRepository(FirebaseDatabase.instance.reference(), FirebaseAuth.instance));
  }
}
