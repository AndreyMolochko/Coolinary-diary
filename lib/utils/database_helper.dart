import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_worker/model/dish.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String tableDishName = 'dish_table';
  String columnId = 'id';
  String columnName = 'name';
  String columnCounterCooking = 'counterCooking';
  String columnCategory = 'category';
  String columnIngredientList = 'ingredientList';
  String columnRecipe = 'recipe';
  String columnPath = 'path';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }

    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }

    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'dishes.db';

    var dishesDatabase =
        openDatabase(path, version: 1, onCreate: _createDatabase);

    return dishesDatabase;
  }

  void _createDatabase(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $tableDishName($columnId INTEGER '
        'PRIMARY KEY AUTOINCREMENT, $columnName TEXT, $columnCounterCooking '
        'INTEGER, $columnCategory TEXT, $columnIngredientList TEXT, '
        '$columnRecipe TEXT, $columnPath TEXT )');
  }

  Future<List<Dish>> getDishesByCategory(String category) async {
    Database db = await this.database;
    var dishesMap = await db.query(tableDishName,
        where: columnCategory +
            ' =? '
                '',
        whereArgs: [category]);
    List<Dish> dishesList = new List();
    for (int i = 0; i < dishesMap.length; i++) {
      dishesList.add(new Dish.fromMapObject(dishesMap[i]));
    }

    return dishesList;
  }

  Future<int> insertDish(Dish dish) async {
    Database db = await this.database;
    var result = await db.insert(tableDishName, dish.toMap());

    return result;
  }

  Future<int> updateDish(Dish dish) async {
    Database db = await this.database;
    var result = await db.update(tableDishName, dish.toMap(),
        where: '$columnId'
            ' = ?',
        whereArgs: [dish.id]);

    return result;
  }

  Future<int> deleteDish(int id) async {
    Database db = await this.database;
    var result =
        await db.delete(tableDishName, where: columnId + '=?', whereArgs: [id]);

    return result;
  }
}
