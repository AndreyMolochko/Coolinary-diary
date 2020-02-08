import 'package:firebase_auth/firebase_auth.dart';
import 'package:sqflite_worker/services/module.dart';

class AuthorizationService implements AuthorizationServiceType {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<AuthResult> signIn(String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<AuthResult> signUp(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }
}
