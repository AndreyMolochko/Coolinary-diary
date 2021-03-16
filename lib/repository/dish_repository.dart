import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sqflite_worker/model/module.dart';

import 'repositories.dart';

class DishRepository implements DishRepositoryType {
  final DatabaseReference _databaseReference;
  final FirebaseAuth _auth;

  DishRepository(this._databaseReference, this._auth);

  @override
  void addClaim(Dish dish) {
    final String userId = _auth.currentUser.uid;
    _databaseReference.child("users/$userId/dishes").push().set(
        dish.toMap()
    );
  }
}