import 'package:flutter/material.dart';
import 'package:sqflite_worker/localization/app_translations.dart';
import 'package:sqflite_worker/app_theme.dart' as AppTheme;

class MultiLineTextField extends StatelessWidget {
  final String labelText;
  final bool validateCookingList;
  final TextEditingController cookingListController;
  final int maxLines;

  MultiLineTextField(this.labelText, this.validateCookingList,
      this.cookingListController, this.maxLines);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: new TextField(
        keyboardType: TextInputType.multiline,
        maxLines: maxLines,
        controller: cookingListController,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: labelText,
            errorText: validateCookingList
                ? null
                : AppTranslations.translate(context, "enter_something"),
            hintStyle: TextStyle(color: AppTheme.Colors.black),labelStyle: TextStyle(color: AppTheme.Colors.black)),
      ),
    );
  }
}
