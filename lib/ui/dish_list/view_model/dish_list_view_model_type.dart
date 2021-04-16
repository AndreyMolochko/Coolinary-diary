import 'package:flutter/cupertino.dart';
import 'package:sqflite_worker/model/module.dart';

abstract class DishListViewModelType {
  String testData;
  Future<List<Dish>> dishesList;

  void initState();
  void clickOnItem(BuildContext context, Dish dish);
}
