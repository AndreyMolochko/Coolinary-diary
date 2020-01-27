import 'package:injector/injector.dart';
import 'package:sqflite_worker/model/request_dish_screen_type.dart';

import '../module.dart';

class RequestDishViewModel implements RequestDishViewModelType {
  @override
  RequestDishScreenType requestDishScreenType;

  final Injector _injector;

  RequestDishViewModel(this._injector, this.requestDishScreenType);
}
