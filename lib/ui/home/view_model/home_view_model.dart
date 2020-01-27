import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:sqflite_worker/model/module.dart';
import 'package:sqflite_worker/ui/dish_list/module.dart';
import 'package:sqflite_worker/ui/home/module.dart';

class HomeViewModel implements HomeViewModelType {
  @override
  int get currentPageIndex => _currentTabBarView;

  @override
  List<Widget> tabBarViews;

  int _currentTabBarView = 0;
  final Injector _injector;
  DishListViewModelType myDishListViewModel;
  DishListViewModelType otherDishListViewModel;

  HomeViewModel(this._injector);

  @override
  void initState() {
    myDishListViewModel = DishListViewModel(_injector, RequestDishListType.myDishes);
    otherDishListViewModel = DishListViewModel(_injector, RequestDishListType.otherDishes);

    tabBarViews = [DishListPage(myDishListViewModel), DishListPage(otherDishListViewModel)];
  }

  @override
  void onTabChange(int index) {
    _currentTabBarView = index;
  }

  @override
  void onClickSettingsIcon(BuildContext context) {
    print("onClick on settings screen");
  }
}
