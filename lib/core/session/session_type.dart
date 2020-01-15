import 'package:injector/injector.dart';

abstract class SessionType {
  void registerDependencies(Injector injector);
}
