import 'package:firebase_database/firebase_database.dart';
import 'package:sqflite_worker/model/module.dart';

import 'repositories.dart';

class DishRepository implements DishRepositoryType {
  final DatabaseReference _databaseReference;

  DishRepository(this._databaseReference);

  @override
  void addClaim(Dish dish) {
    _databaseReference.child("dishes").push().set(
        dish.toMap()
    );
  }
}