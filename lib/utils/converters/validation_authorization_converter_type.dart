import 'package:flutter/material.dart';
import 'package:sqflite_worker/model/module.dart';

abstract class ValidationAuthorizationConverterType {
  String getErrorMessage(BuildContext context, ValidationStatusAuthorization validationStatus);
}