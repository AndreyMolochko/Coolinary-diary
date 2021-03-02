import 'package:sqflite_worker/model/module.dart';

abstract class AuthorizationServiceType {
  Future<AuthResult> signIn(String email, String password);

  Future<AuthResult> signUp(String email, String password);
}