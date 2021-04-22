import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqflite_worker/model/module.dart';
import 'package:sqflite_worker/repository/repositories.dart';
import 'package:sqflite_worker/ui/dish_info/module.dart';
import 'package:sqflite_worker/ui/dish_list/module.dart';

class DishListViewModel implements DishListViewModelType {
  final Injector _injector;
  final RequestDishListType _dishListType;
  DishRepositoryType _repository;
  final _dishListController = BehaviorSubject<List<Dish>>();

  DishListViewModel(this._injector, this._dishListType) {
    _repository = _injector.get<DishRepositoryType>();
  }

  @override
  void initState() async {
    if (_dishListType == RequestDishListType.myDishes) {
      _repository.getDishes(true).listen((dishesList) {
        _dishListController.sink.add(dishesList);
      });
    } else if (_dishListType == RequestDishListType.otherDishes) {
      _repository.getDishes(false).listen((dishesList) {
        _dishListController.sink.add(dishesList);
      });
    }
  }

  @override
  Stream<List<Dish>> get dishesList => _dishListController.stream;

  @override
  void clickOnItem(BuildContext context, Dish dish, RequestDishListType type) {
    Navigator.of(context).pushNamed('/dish_info', arguments: DishInfoViewModel(_injector, dish, type));
  }

  @override
  void onDispose() {
    _dishListController.close();
  }
}
