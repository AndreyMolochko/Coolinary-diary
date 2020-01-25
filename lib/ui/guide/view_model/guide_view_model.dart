import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:sqflite_worker/providers/module.dart';
import 'package:sqflite_worker/ui/dish_list/module.dart';

import '../module.dart';

class GuideViewModel implements GuideViewModelType {
  final Injector _injector;
  SharedPreferencesProviderType _sharedPreferencesProvider;

  GuideViewModel(this._injector) {
    _sharedPreferencesProvider = _injector.getDependency<SharedPreferencesProviderType>();
  }

  @override
  void continueButtonAction(BuildContext context) {
    _sharedPreferencesProvider.saveShowingGuidePage(true);
    DishListViewModelType dishListViewModel = DishListViewModel(_injector);
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => DishListPage(dishListViewModel)));
  }
}
