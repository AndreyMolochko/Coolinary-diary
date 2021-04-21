import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:sqflite_worker/model/dish.dart';
import 'package:sqflite_worker/model/module.dart';
import 'package:sqflite_worker/repository/repositories.dart';
import 'package:sqflite_worker/ui/dish_info/module.dart';
import 'package:sqflite_worker/ui/request_dish/module.dart';
import 'package:sqflite_worker/ui/request_dish/widgets/choose_name_and_category_page.dart';

class DishInfoViewModel implements DishInfoViewModelType {

  final Injector _injector;
  DishRepositoryType _repository;

  DishInfoViewModel(this._injector, Dish dish, RequestDishListType type) {
    _repository = _injector.get<DishRepositoryType>();
    this.dish = dish;
    requestDishListType = type;
  }

  @override
  Dish dish;

  @override
  void onClickDelete(BuildContext context, Dish dish) {
    _repository.removeDish(dish);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  @override
  void onClickUpdate(BuildContext context, Dish dish) {
    RequestDishViewModelType requestDishViewModel = RequestDishViewModel(
        _injector, RequestDishScreenType.updateDish, dish: dish);
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ChooseNameAndCategoryPage(requestDishViewModel)));
  }

  @override
  RequestDishListType requestDishListType;
}