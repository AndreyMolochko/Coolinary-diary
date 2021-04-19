import 'package:flutter/cupertino.dart';
import 'package:sqflite_worker/model/module.dart';

abstract class DishListViewModelType {
  String testData;
  Stream<List<Dish>> get dishesList;

  void initState();
  void clickOnItem(BuildContext context, Dish dish);
  void onDispose();
}
