import 'package:injector/injector.dart';
import 'package:sqflite_worker/model/request_dish_list_type.dart';
import 'package:sqflite_worker/ui/home/module.dart';

class HomeViewModel implements HomeViewModelType {

  @override
  List<RequestDishListType> dishListTypes;

  final Injector _injector;

  HomeViewModel(this._injector);

  @override
  void initState() {

  }
}