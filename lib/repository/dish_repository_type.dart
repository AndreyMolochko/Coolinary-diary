import 'package:sqflite_worker/model/module.dart';

abstract class DishRepositoryType {
  void addDish(Dish dish);
  Stream<List<Dish>> getDishes(bool isMyDishes);
  Future<void> removeDish(Dish dish);
}
