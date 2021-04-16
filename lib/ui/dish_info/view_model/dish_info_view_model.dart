import 'package:sqflite_worker/model/dish.dart';
import 'package:sqflite_worker/ui/dish_info/module.dart';

class DishInfoViewModel implements DishInfoViewModelType {
  @override
  Dish dish;

  DishInfoViewModel(Dish dish) {
    this.dish = dish;
  }
}