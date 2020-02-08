import 'package:firebase_auth/firebase_auth.dart';
import 'package:sqflite_worker/services/module.dart';

class AuthorizationService implements AuthorizationServiceType {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  void signIn(String email, String password) {

  }

  @override
  void signUp(String email, String password) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser firebaseUser = result.user;
  }

}