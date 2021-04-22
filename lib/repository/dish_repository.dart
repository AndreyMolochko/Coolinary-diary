import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sqflite_worker/model/module.dart';

import 'repositories.dart';

class DishRepository implements DishRepositoryType {
  final DatabaseReference _databaseReference;
  final FirebaseAuth _auth;
  final FirebaseStorage _firebaseStorage;

  DishRepository(this._databaseReference, this._auth, this._firebaseStorage);

  @override
  void addDish(Dish dish) async {
    final String userId = _auth.currentUser.uid;
    dish.path = await _uploadFile(userId, File(dish.path));
    _databaseReference.child("users/$userId/dishes").push().set(
        dish.toMap()
    );
  }

  @override
  Stream<List<Dish>> getDishes(bool isMyDishes) {
    List<Dish> dishesList = [];
    if (isMyDishes) {
      final String userId = _auth.currentUser.uid;
      return _databaseReference.child("users/$userId/dishes").onValue.map((event) {
        dishesList.clear();
        event.snapshot.value.forEach((index, data) => dishesList.add(Dish.fromMapObject(index, data)));
        return dishesList;
      });
    } else {
      return _databaseReference.child("common_dishes").onValue.map((event) {
        dishesList.clear();
        event.snapshot.value.forEach((index, data) => dishesList.add(Dish.fromMapObject(index, data)));
        return dishesList;
      });
    }
  }

  Future<String> _uploadFile(String userId, File image) async {
    UploadTask uploadTask = _firebaseStorage.ref().child('user_dishes/$userId/${image.path.split('/').last}').putFile(image);
    TaskSnapshot storageTaskSnapshot = await uploadTask.whenComplete(() => null);
    String url = await storageTaskSnapshot.ref.getDownloadURL();
    return url;
  }

  @override
  Future<void> removeDish(Dish dish) async {
    final String userId = _auth.currentUser.uid;
    await _removeImageFromStorage(dish.path);
    return await _databaseReference.child('users/$userId/dishes/${dish.id}').remove();
  }

  Future<void> _removeImageFromStorage(String filename) async {
    await _firebaseStorage.refFromURL(filename).delete();
  }

  @override
  Future<void> updateDish(Dish dish, String previousFilename) async {
    final String userId = _auth.currentUser.uid;
    if (dish.path != previousFilename) {
      await _removeImageFromStorage(previousFilename);
      dish.path = await _uploadFile(userId, File(dish.path));
    }
    await _databaseReference.child('users/$userId/dishes/${dish.id}').update(dish.toMap());
  }
}