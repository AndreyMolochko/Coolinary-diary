import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sqflite_worker/model/module.dart';

import 'repositories.dart';

class DishRepository implements DishRepositoryType {
  final DatabaseReference _databaseReference;
  final FirebaseAuth _auth;
  final Reference _storageReference;

  DishRepository(this._databaseReference, this._auth, this._storageReference);

  @override
  void addDish(Dish dish) async {
    final String userId = _auth.currentUser.uid;
    dish.path = await _uploadFile(userId, File(dish.path));
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
        dishesList.add(Dish.fromMapObject(index, data)));
    } else {
      DataSnapshot data = await _databaseReference.child("common_dishes").once();
      data.value.forEach((index, data) => dishesList.add(Dish.fromMapObject(index, data)));
    }
    return dishesList;
  }

  Future<String> _uploadFile(String userId, File image) async {
    UploadTask uploadTask = _storageReference.child('user_dishes/$userId/${image.path.split('/').last}').putFile(image);
    TaskSnapshot storageTaskSnapshot = await uploadTask.whenComplete(() => null);
    String url = await storageTaskSnapshot.ref.getDownloadURL();
    return url;
  }

  @override
  void removeDish(Dish dish) async {
    final String userId = _auth.currentUser.uid;
    await _databaseReference.child('users/$userId/dishes/${dish.id}').remove();
  }
}