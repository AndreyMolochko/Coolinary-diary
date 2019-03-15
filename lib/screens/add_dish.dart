import 'package:flutter/material.dart';
import 'package:sqflite_worker/resourses/strings.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite_worker/model/dish.dart';
import 'package:sqflite_worker/utils/database_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddDish extends StatefulWidget {
  @override
  _AddDishState createState() => _AddDishState();
}

class _AddDishState extends State<AddDish> {
  var nameController = new TextEditingController();
  var cookingListController = new TextEditingController();
  var ingredientListController = new TextEditingController();
  String category;
  List<DropdownMenuItem<String>> _dropDownMenuItems;

  DatabaseHelper databaseHelper = new DatabaseHelper();
  bool validateName = false;
  bool validateCookingList = false;
  bool validateIngredient = false;
  File image;

  @override
  void initState() {
    _initControllers();
    _dropDownMenuItems = getDropDownMenuItems();
    category = _dropDownMenuItems[0].value;
  }

  void _initControllers() {
    nameController.addListener(() {
      setState(() {
        validateName = getValidation(nameController);
      });
    });

    cookingListController.addListener(() {
      setState(() {
        validateCookingList = getValidation(cookingListController);
      });
    });

    ingredientListController.addListener(() {
      setState(() {
        validateIngredient = getValidation(ingredientListController);
      });
    });
  }

  bool getValidation(TextEditingController controller) {
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
        title: new Text("Add dish"),
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
                    icon: image == null? new Icon(Icons.image):new Image.file
    (image),
                    onPressed: () {
                      _showDialog();
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
                  child: new Text("Add dish"),
                  onPressed: onClickAddDish,
                ),
              ),
            )
          ],
        )),
      ),
    );
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

  bool isValidAllField() {
    if (validateName && validateIngredient && validateCookingList) {
      return true;
    } else {
      return false;
    }
  }

  void changeDropDownItem(String selectedCategory) {
    setState(() {
      category = selectedCategory;
    });
  }

  void onClickAddDish() {
    if (isValidAllField()) {
      insertDishFromFields();
    }
  }

  void insertDishFromFields() async {
    Dish dish = new Dish(
        nameController.text,
        0,
        category,
        ingredientListController.text,
        cookingListController.text,
        image.path);

    int result = await databaseHelper.insertDish(dish);
    if (result != 0) {
      // Success
      print('Dish Saved Successfully');
      Navigator.pop(context);
    } else {
      // Failure
      print('Problem Saving Dish');
    }

    print(dish.name);
    print(dish.category);
    print(dish.ingredientList);
    print(dish.recipe);
    print(dish.path);
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return _getAlertDialog();
        });
  }

  Widget _getAlertDialog() {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InkWell(
            onTap: _clickOnCamera,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Text("Camera", style: new TextStyle(fontSize: 18.0)),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: _clickOnGallery,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Text("Gallery", style: new TextStyle(fontSize: 18.0)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _clickOnCamera()async {
    image = await ImagePicker.pickImage(source: ImageSource.camera);
    print(image.path);
    setState(() {

    });
  }

  void _clickOnGallery()async {
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    print(image.path);
    setState(() {

    });
  }

}
