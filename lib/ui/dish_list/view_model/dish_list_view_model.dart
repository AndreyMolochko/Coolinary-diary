import 'package:injector/injector.dart';
import 'package:sqflite_worker/model/module.dart';
import 'package:sqflite_worker/ui/dish_list/module.dart';

class DishListViewModel implements DishListViewModelType {
  final Injector _injector;
  final RequestDishListType _dishListType;

  @override
  String testData;

  DishListViewModel(this._injector, this._dishListType);

  @override
  void initState() {
    if(_dishListType == RequestDishListType.myDishes) {
      testData = "My dishes";
    } else {
      testData = "Other dishes";
    }
  }


}