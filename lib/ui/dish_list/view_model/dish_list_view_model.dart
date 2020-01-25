import 'package:injector/injector.dart';
import 'package:sqflite_worker/ui/dish_list/module.dart';

class DishListViewModel implements DishListViewModelType {

  final Injector _injector;

  DishListViewModel(this._injector);

}