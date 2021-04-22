import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqflite_worker/model/dish.dart';
import 'package:sqflite_worker/model/module.dart';
import 'package:sqflite_worker/repository/repositories.dart';
import 'package:sqflite_worker/ui/dialogs/module.dart';
import 'package:sqflite_worker/ui/dish_info/module.dart';
import 'package:sqflite_worker/ui/request_dish/module.dart';
import 'package:sqflite_worker/ui/request_dish/widgets/choose_name_and_category_page.dart';

class DishInfoViewModel implements DishInfoViewModelType {

  final Injector _injector;
  DishRepositoryType _repository;
  final _isLoadingController = BehaviorSubject<bool>();

  DishInfoViewModel(this._injector, Dish dish, RequestDishListType type) {
    _repository = _injector.get<DishRepositoryType>();
    this.dish = dish;
    requestDishListType = type;
    _isLoadingController.sink.add(false);
  }

  @override
  Dish dish;

  @override
  void onClickDelete(BuildContext context, Dish dish) {
    Navigator.of(context).pop();
    _repository.removeDish(dish).then((value) {
      _isLoadingController.sink.add(true);
    }).whenComplete(() {
      _isLoadingController.sink.add(false);
      Navigator.of(context).pop();
    }).onError((error, stackTrace) {
      _isLoadingController.sink.add(false);
      _showDialog("", error, context);
    });
  }

  @override
  void onClickUpdate(BuildContext context, Dish dish) {
    RequestDishViewModelType requestDishViewModel = RequestDishViewModel(
        _injector, RequestDishScreenType.updateDish, dish: dish);
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ChooseNameAndCategoryPage(requestDishViewModel)));
  }

  @override
  RequestDishListType requestDishListType;

  @override
  Stream<bool> get isLoading => _isLoadingController.stream;

  @override
  void dispose() {
    _isLoadingController.close();
  }

  void _showDialog(String title, String message, BuildContext context) {
    DialogPresenterType dialogPresenter = DialogPresenter(title, message);
    dialogPresenter.show(context);
  }
}