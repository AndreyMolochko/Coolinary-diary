import 'package:injector/injector.dart';
import 'package:sqflite_worker/model/authorization_type.dart';
import 'package:sqflite_worker/ui/authorization/module.dart';

class AuthorizationViewModel implements AuthorizationViewModelType {
  @override
  AuthorizationType get authorizationType => null;

  final Injector _injector;

  AuthorizationViewModel(this._injector, AuthorizationType authorizationType) {
    authorizationType = authorizationType;
  }

  @override
  void initState() {

  }
}