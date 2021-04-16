class Dish {
  var _id;
  String _name;
  String _category;
  String _ingredientList;
  String _recipe;
  String _path;
  DateTime _createdAt;
  DateTime _updatedAt;

  Dish.empty();

  Dish(this._name, this._category, this._ingredientList,
      this._recipe, this._path);

  Dish.withId(this._id, this._name, this._category,
      this._ingredientList, this._recipe, this._path);

  Dish.fromMapObject(String id, Map<dynamic, dynamic> map) {
    this._id = id;
    this._name = map['name'];
    this._category = map['category'];
    this._ingredientList = map['ingredientList'];
    this._recipe = map['recipe'];
    this._path = map['path'];
    this._createdAt = DateTime.fromMillisecondsSinceEpoch(map['createdAt']);
    this._updatedAt = DateTime.fromMillisecondsSinceEpoch(map['updatedAt']);
  }

  get id => _id;

  set id(value) {
    _id = value;
  }

  String get name => _name;

  String get path => _path;

  set path(String value) {
    _path = value;
  }

  String get recipe => _recipe;

  set recipe(String value) {
    _recipe = value;
  }

  String get ingredientList => _ingredientList;

  set ingredientList(String value) {
    _ingredientList = value;
  }

  String get category => _category;

  set category(String value) {
    _category = value;
  }

  set name(String value) {
    _name = value;
  }

  DateTime get createdAt => _createdAt;

  set createdAt(DateTime value) {
    _createdAt = value;
  }

  DateTime get updatedAt => _updatedAt;

  set updatedAt(DateTime value) {
    _updatedAt = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['category'] = _category;
    map['ingredientList'] = _ingredientList;
    map['recipe'] = _recipe;
    map['path'] = _path;
    map['createdAt'] = DateTime.now().millisecondsSinceEpoch;
    map['updatedAt'] = DateTime.now().millisecondsSinceEpoch;

    return map;
  }
}
