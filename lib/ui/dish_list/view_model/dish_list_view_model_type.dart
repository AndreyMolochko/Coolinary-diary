import 'package:flutter/cupertino.dart';
import 'package:sqflite_worker/model/module.dart';

abstract class DishListViewModelType {
  Stream<List<Dish>> get dishesList;

  void initState();
  void clickOnItem(BuildContext context, Dish dish, RequestDishListType type);
  void onDispose();
}
