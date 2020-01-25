import 'package:flutter/material.dart';
import 'package:sqflite_worker/ui/dish_list/module.dart';

class DishListPage extends StatefulWidget {

  final DishListViewModelType dishListViewModel;

  DishListPage(this.dishListViewModel);

  @override
  _DishListPageState createState() => _DishListPageState();
}

class _DishListPageState extends State<DishListPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
