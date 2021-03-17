import 'package:injector/injector.dart';
import 'package:sqflite_worker/model/module.dart';
import 'package:sqflite_worker/repository/repositories.dart';
import 'package:sqflite_worker/ui/dish_list/module.dart';

class DishListViewModel implements DishListViewModelType {
  final Injector _injector;
  final RequestDishListType _dishListType;
  DishRepositoryType _repository;

  @override
  String testData;

  DishListViewModel(this._injector, this._dishListType) {
    _repository = _injector.get<DishRepositoryType>();
  }

  @override
  void initState() async {
    if (_dishListType == RequestDishListType.myDishes) {
      dishesList =  _repository.getDishes(true);
      testData = "My dishes";
    } else if (_dishListType == RequestDishListType.otherDishes) {
      dishesList = _repository.getDishes(false);
      testData = "Other dishes";
    }
  }

  @override
  Future<List<Dish>> dishesList;
}
