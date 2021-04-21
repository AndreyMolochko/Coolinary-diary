import 'package:flutter/cupertino.dart';
import 'package:sqflite_worker/model/dish.dart';
import 'package:sqflite_worker/model/module.dart';

abstract class RequestDishViewModelType {

  Dish dish;
  String getPageTitle(BuildContext context);
  RequestDishScreenType requestDishScreenType;
  void clickContinueNameCategory(BuildContext context, String name, String category);
  void clickContinueRecipeIngredients(BuildContext context, String ingredients, String recipe);
  void clickOnSave(BuildContext context, String path, String previousFilename);
}
