import 'package:sqflite_worker/model/module.dart';

abstract class DishRepositoryType {
  void addDish(Dish dish);
  Future<List<Dish>> getDishes(bool isMyDishes);
}
