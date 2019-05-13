import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite_worker/model/dish.dart';
import 'package:sqflite_worker/resourses/strings.dart';
import 'package:sqflite_worker/utils/database_helper.dart';
import 'package:sqflite_worker/utils/utils.dart';
import 'package:sqflite_worker/widgets/camera_alert_dialog.dart';
import 'package:sqflite_worker/widgets/image_addition_dish_widget.dart';
import 'package:sqflite_worker/widgets/add_dish_button.dart';

typedef void Callback();

class AddDish extends StatefulWidget {
  final Callback callback;

  AddDish(this.callback);

  @override
  _AddDishState createState() => _AddDishState(callback);
}

class _AddDishState extends State<AddDish> {
  final Callback callback;
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

  _AddDishState(this.callback);

  @override
  void initState() {
    _initControllers();
    _dropDownMenuItems = getDropDownMenuItems();
    category = _dropDownMenuItems[0].value;
  }

  void _initControllers() {
    nameController.addListener(() {
      setState(() {
        validateName = Utils.getValidation(nameController.text);
      });
    });

    cookingListController.addListener(() {
      setState(() {
        validateCookingList = Utils.getValidation(cookingListController.text);
      });
    });

    ingredientListController.addListener(() {
      setState(() {
        validateIngredient = Utils.getValidation(ingredientListController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Add dish"),
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
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
                                  errorText:
                                      validateName ? null : 'Enter something'),
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
                          child: ImageNewDish(
                            image: image,
                            onPressed: _showDialog,
                          )),
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
                                  errorText: validateCookingList
                                      ? null
                                      : 'Enter something'),
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
                                  errorText: validateIngredient
                                      ? null
                                      : 'Enter something'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 8.0),
                    child: SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: RaisedButton(
                        color: Colors.grey,
                        child: new Text("Add dish"),
                        onPressed: () {
                          onClickAddDish(context);
                        },
                      ),
                    ),
                  )
                ],
              )),
            ),
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

  void onClickAddDish(var context) {
    if (isValidAllField() && image != null) {
      insertDishFromFields();
    } else {
      _showSnackbarError(context);
    }
  }

  void insertDishFromFields() async {
    Dish dish = new Dish(nameController.text, 0, category,
        ingredientListController.text, cookingListController.text, image.path);

    int result = await databaseHelper.insertDish(dish);
    if (result != 0) {
      print('Dish Saved Successfully');
      callback();
      Navigator.pop(context);
    } else {
      print('Problem Saving Dish');
    }
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CameraAlertDialog(
              "Camera", "Gallery", _clickOnCamera, _clickOnGallery);
        });
  }

  void _clickOnCamera() async {
    Navigator.pop(context);
    image = await ImagePicker.pickImage(source: ImageSource.camera);
    print(image.path);
    setState(() {});
  }

  void _clickOnGallery() async {
    Navigator.pop(context);
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    print(image.path);
    setState(() {});
  }

  void _showSnackbarError(var context) {
    final snackbar = new SnackBar(
      content: Text("You need to fill all fields and add photo"),
    );
    Scaffold.of(context).showSnackBar(snackbar);
  }
}
