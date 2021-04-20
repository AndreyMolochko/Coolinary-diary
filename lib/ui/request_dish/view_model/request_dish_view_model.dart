import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:sqflite_worker/model/dish.dart';
import 'package:sqflite_worker/model/request_dish_screen_type.dart';
import 'package:sqflite_worker/repository/dish_repository_type.dart';
import 'package:sqflite_worker/ui/request_dish/widgets/add_dish_photo_page.dart';
import 'package:sqflite_worker/ui/request_dish/widgets/filling_ingredients_and_recipe_page.dart';

import '../module.dart';

class RequestDishViewModel implements RequestDishViewModelType {

  final Injector _injector;
  DishRepositoryType _repository;

  RequestDishViewModel(this._injector, this.requestDishScreenType, {this.dish}) {
    if (dish == null) {
      dish = Dish.empty();
    }
    _repository = _injector.get<DishRepositoryType>();
  }

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

  @override
  Dish dish;

  @override
  void saveImagePath(String path) => dish.path = path;

  @override
  void addDish() => _repository.addDish(dish);

  @override
  void clickContinueNameCategory(BuildContext context, String name, String category) {
    dish.name = name;
    dish.category = category;
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => IngredientsAndRecipePage(this)));
  }

  @override
  void clickContinueRecipeIngredients(BuildContext context, String ingredients, String recipe) {
    dish.ingredientList = ingredients;
    dish.recipe = recipe;
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AddDishPhotoPage(this)));
  }

}
