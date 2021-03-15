import 'package:flutter/cupertino.dart';
import 'package:sqflite_worker/model/dish.dart';
import 'package:sqflite_worker/model/module.dart';

abstract class RequestDishViewModelType {

  Dish dish;
  String getPageTitle(BuildContext context);
  RequestDishScreenType requestDishScreenType;
  void saveDishName(String name);
  void saveCategory(String category);
  void saveIngredients(String ingredients);
  void saveRecipe(String recipe);
  void saveImagePath(String path);
  void addDish();
}
