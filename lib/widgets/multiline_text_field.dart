import 'package:flutter/material.dart';

class MultiLineTextField extends StatelessWidget{

  final String labelText;
  final bool validateCookingList;
  final TextEditingController cookingListController;
  final int maxLines;

  MultiLineTextField(
      this.labelText, this.validateCookingList, this.cookingListController,this.maxLines);


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
            errorText: validateCookingList ? null : 'Enter something'),
      ),
    );
  }
}
