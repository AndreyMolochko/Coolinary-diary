import 'package:flutter/material.dart';
import 'package:sqflite_worker/model/module.dart';

abstract class DishInfoViewModelType {
  Dish dish;
  RequestDishListType requestDishListType;
  Stream<bool> get isLoading;

  void onClickUpdate(BuildContext context, Dish dish);
  void onClickDelete(BuildContext context, Dish dish);
  void dispose();
}