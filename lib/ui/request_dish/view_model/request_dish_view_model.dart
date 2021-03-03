import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:sqflite_worker/model/dish.dart';
import 'package:sqflite_worker/model/request_dish_screen_type.dart';

import '../module.dart';

class RequestDishViewModel implements RequestDishViewModelType {

  @override
  String getPageTitle(BuildContext context) {
    switch (requestDishScreenType) {
      case RequestDishScreenType.addDish:
        return "Add dish";
      case RequestDishScreenType.updateDish:
        return "Update dish";
    }
  }

  @override
  RequestDishScreenType requestDishScreenType;

  final Injector _injector;

  RequestDishViewModel(this._injector, this.requestDishScreenType) {
    dish = Dish.empty();
  }

  @override
  Dish dish;

  @override
  void saveCategory(String category) => dish.category = category;

  @override
  void saveDishName(String name) => dish.name = name;

  @override
  void saveIngredients(String ingredients) => dish.ingredientList = ingredients;

  @override
  void saveRecipe(String recipe) => dish.recipe = recipe;


}
