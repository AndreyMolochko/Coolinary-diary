import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite_worker/model/dish.dart';
import 'package:sqflite_worker/resourses/strings.dart';
import 'package:sqflite_worker/utils/database_helper.dart';
import 'package:sqflite_worker/widgets/camera_alert_dialog.dart';
import 'package:sqflite_worker/widgets/image_addition_dish_widget.dart';
import 'package:sqflite_worker/widgets/multiline_text_field.dart';

typedef void Callback();

class UpdateDish extends StatefulWidget {
  final Dish dish;
  final Callback callback;

  UpdateDish(this.dish, this.callback);

  @override
  _UpdateDishState createState() => _UpdateDishState(dish, callback);
}

class _UpdateDishState extends State<UpdateDish> {
  Dish dish;
  final Callback callback;

  _UpdateDishState(this.dish, this.callback);

  bool validateName = false;
  bool validateCookingList = false;
  bool validateIngredient = false;

  var nameController = new TextEditingController();
  var cookingListController = new TextEditingController();
  var ingredientListController = new TextEditingController();
  String category = "Soups";
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  File image;

  DatabaseHelper databaseHelper = new DatabaseHelper();

  @override
  void initState() {
    image = new File(dish.path);
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
                  child: _getWidgetWithPadding(MultiLineTextField(
                      "Name", validateName, nameController, 1)),
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
                    onChanged: _changeDropDownItem,
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: _getWidgetWithPadding(MultiLineTextField(
                      "Cooking list",
                      validateCookingList,
                      cookingListController,
                      4)),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: _getWidgetWithPadding(MultiLineTextField(
                      "Ingredient list",
                      validateIngredient,
                      ingredientListController,
                      4)),
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

  void _changeDropDownItem(String selectedCategory) {
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
    int result = await databaseHelper.updateDish(_getDishFromFields());
    callback();
    Navigator.pop(context);
  }

  Dish _getDishFromFields() {
    return new Dish.withId(this.dish.id,
        nameController.text,
        this.dish.counterCooking,
        category,
        ingredientListController.text,
        cookingListController.text,
        image.path);
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

  Widget _getWidgetWithPadding(Widget widget) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
      child: widget,
    );
  }

  bool _isValidAllField() {
    if (validateName && validateIngredient && validateCookingList) {
      return true;
    } else {
      return false;
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
    image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {});
  }

  void _clickOnGallery() async {
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }
}
