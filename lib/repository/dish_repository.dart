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

  @override
  Future<List<Dish>> getDishes(bool isMyDishes) async {
    List<Dish> dishesList = [];
    if (isMyDishes) {
      final String userId = _auth.currentUser.uid;
      DataSnapshot data = await _databaseReference.child("users/$userId/dishes").once();
      data.value.forEach((index, data) =>
        dishesList.add(Dish.fromMapObject(data)));
    } else {
      DataSnapshot data = await _databaseReference.child("common_dishes").once();
      data.value.forEach((index, data) => dishesList.add(Dish.fromMapObject(data)));
    }
    return dishesList;
  }
}