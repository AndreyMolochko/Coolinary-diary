import 'package:flutter/cupertino.dart';
import 'package:sqflite_worker/model/module.dart';

abstract class RequestDishViewModelType {

  String getPageTitle(BuildContext context);
  RequestDishScreenType requestDishScreenType;

}
