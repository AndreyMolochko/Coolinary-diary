import 'package:firebase_auth/firebase_auth.dart';
import 'package:sqflite_worker/model/module.dart';
import 'package:sqflite_worker/services/module.dart';

class AuthorizationService implements AuthorizationServiceType {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<AuthResult> signIn(String email, String password) async {
    final userCreds = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return Future.value(AuthResult(userCreds.user.uid));
  }

  @override
  Future<AuthResult> signUp(String email, String password) async {
    final userCreds = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return Future.value(AuthResult(userCreds.user.uid));
  }
}
