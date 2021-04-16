import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:sqflite_worker/model/dish.dart';
import 'package:sqflite_worker/repository/repositories.dart';
import 'package:sqflite_worker/ui/dish_info/module.dart';

class DishInfoViewModel implements DishInfoViewModelType {

  final Injector _injector;
  DishRepositoryType _repository;

  DishInfoViewModel(this._injector, Dish dish) {
    _repository = _injector.get<DishRepositoryType>();
    this.dish = dish;
  }

  @override
  Dish dish;

  @override
  void onClickDelete(BuildContext context, Dish dish) {
    _repository.removeDish(dish);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }
}