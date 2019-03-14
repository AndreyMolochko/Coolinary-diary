import 'package:flutter/material.dart';
import 'package:sqflite_worker/resourses/strings.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite_worker/model/dish.dart';
import 'package:sqflite_worker/utils/database_helper.dart';

class UpdateDish extends StatefulWidget {
  final Dish dish;

  UpdateDish(this.dish);

  @override
  _UpdateDishState createState() => _UpdateDishState(dish);
}

class _UpdateDishState extends State<UpdateDish> {
  Dish dish;

  _UpdateDishState(this.dish);

  bool validateName = false;
  bool validateCookingList = false;
  bool validateIngredient = false;

  var nameController = new TextEditingController();
  var cookingListController = new TextEditingController();
  var ingredientListController = new TextEditingController();
  String category = "Soups";
  List<DropdownMenuItem<String>> _dropDownMenuItems;

  DatabaseHelper databaseHelper = new DatabaseHelper();

  @override
  void initState() {
    _initControllers();
    _initWidgets();
  }

  void _initControllers() {
    nameController.addListener(() {
      setState(() {
        validateName = _getValidation(nameController);
      });
    });

    cookingListController.addListener(() {
      setState(() {
        validateCookingList = _getValidation(cookingListController);
      });
    });

    ingredientListController.addListener(() {
      setState(() {
        validateIngredient = _getValidation(ingredientListController);
      });
    });
  }

  bool _getValidation(TextEditingController controller) {
    if (controller.text.isNotEmpty && controller.text.trim().length > 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Change dish"),
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: new TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Name",
                            errorText: validateName ? null : 'Enter something'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: IconButton(
                    icon: new Icon(Icons.image),
                    onPressed: () {
                      //TODO:work with camera
                      Fluttertoast.showToast(msg: "In develop");
                    },
                    iconSize: 48,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: DropdownButton(
                    value: category,
                    items: _dropDownMenuItems,
                    onChanged: changeDropDownItem,
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: new TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        controller: cookingListController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Cooki"
                                "ng list",
                            errorText:
                                validateCookingList ? null : 'Enter something'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: new TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        controller: ingredientListController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Ingre"
                                "dient list",
                            errorText:
                                validateIngredient ? null : 'Enter something'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
              child: SizedBox(
                height: 48,
                width: double.infinity,
                child: RaisedButton(
                  color: Colors.grey,
                  child: new Text("Change dish"),
                  onPressed: onClickChangeDish,
                ),
              ),
            )
          ],
        )),
      ),
    );
  }

  void changeDropDownItem(String selectedCategory) {
    setState(() {
      category = selectedCategory;
    });
  }

  void onClickChangeDish() {
    if (_isValidAllField()) {
      updateDish();
    }
  }

  void _initWidgets() {
    _dropDownMenuItems = getDropDownMenuItems();
    nameController.text = dish.name;
    cookingListController.text = dish.recipe;
    ingredientListController.text = dish.ingredientList;
    category = _getMenuItemByCategory(dish.category).value;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String category in listCategories) {
      items.add(new DropdownMenuItem(
          value: category,
          child: new Text(
            category,
            style: new TextStyle(fontSize: 18.0),
          )));
    }

    return items;
  }

  void updateDish() async {
    Dish dish = new Dish.withId(
        this.dish.id,
        nameController.text,
        this.dish.counterCooking,
        category,
        ingredientListController.text,
        cookingListController.text,
        testUrlImage);
    int result = await databaseHelper.updateDish(dish);
    Navigator.pop(context);
  }

  DropdownMenuItem<String> _getMenuItemByCategory(String category) {
    switch (category) {
      case "Soups":
        return _dropDownMenuItems[0];
      case "Main":
        return _dropDownMenuItems[1];
      case "Salads":
        return _dropDownMenuItems[2];
      case "Dessert":
        return _dropDownMenuItems[3];
      case "Drink":
        return _dropDownMenuItems[4];
    }
  }

  bool _isValidAllField() {
    if (validateName && validateIngredient && validateCookingList) {
      return true;
    } else {
      return false;
    }
  }
}
