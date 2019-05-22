import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite_worker/localization/app_translations.dart';
import 'package:sqflite_worker/model/dish.dart';
import 'package:sqflite_worker/utils/database_helper.dart';
import 'package:sqflite_worker/widgets/line.dart';

class CookingDish extends StatefulWidget {
  Dish dish;

  CookingDish(this.dish);

  @override
  _CookingDishState createState() => _CookingDishState(dish);
}

class _CookingDishState extends State<CookingDish> {
  Dish dish;
  BuildContext contextSnackbar;

  DatabaseHelper databaseHelper = new DatabaseHelper();

  _CookingDishState(this.dish);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text(AppTranslations.translate(context, "cooking_dish")),),
      body: Builder(
        builder:(context)=> Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16.0),
              child: Row(
                children: <Widget>[
                  dish.path.length>0?Image.file(new File
                    (dish.path),height: 48,width: 48,):Icon(Icons.image),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: new Text(
                      dish.name,
                      style: new TextStyle(fontSize: 18.0),
                    ),
                  ),
                ],
              ),
            ),
            Text(AppTranslations.translate(context, "ingredient_list"),
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
            line(),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: new Text(
                      dish.ingredientList,
                      style: new TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
            line(),
            Text(AppTranslations.translate(context,"cooking_list"),
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: new Text(
                      dish.recipe,
                      style: new TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: RaisedButton(
                    child: new Text(AppTranslations.translate(context,"end_cooking")),
                    onPressed: (){
                      contextSnackbar = context;
                      _showSnackbarForFinish();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: RaisedButton(
                    child: new Text(AppTranslations.translate(context,"cancel_cooking")),
                    onPressed: (){
                      contextSnackbar = context;
                      _showSnackbarForCancel();
                    },
                  ),
                )
              ],
            )
          ],
        ),
      )
    );
  }

  Widget line() {
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
      child: LineWidget()
    );
  }

  void _showSnackbarForFinish() {
    final snackbar = new SnackBar(
      content: Text(AppTranslations.translate(context,"want_finish_dish")),
      action: SnackBarAction(label: AppTranslations.translate(context,"yes"), onPressed: _clickOnFinishSnackbar),
    );
    Scaffold.of(contextSnackbar).showSnackBar(snackbar);
  }

  void _showSnackbarForCancel() {
    final snackbar = new SnackBar(
      content: Text(AppTranslations.translate(context,"want_cancel_dish")),
      action: SnackBarAction(label: AppTranslations.translate(context,"yes"), onPressed: _clickOnCancelSnackbar),
    );
    Scaffold.of(contextSnackbar).showSnackBar(snackbar);
  }

  void _clickOnFinishSnackbar() {
    dish.counterCooking++;
    updateDish(dish);
    closeCurrentScreen();
  }

  void _clickOnCancelSnackbar() {
    closeCurrentScreen();
  }

  void updateDish(Dish dish)async{
    int result = await databaseHelper.updateDish(dish);
  }

  void closeCurrentScreen(){
    Navigator.pop(context);
  }
}
