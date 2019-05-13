import 'package:flutter/material.dart';

class MultiLineTextField extends StatefulWidget {
  final String labelText;
  final bool validateCookingList;
  final TextEditingController cookingListController;

  MultiLineTextField(
      this.labelText, this.validateCookingList, this.cookingListController);

  @override
  _MultiLineTextFieldState createState() => _MultiLineTextFieldState();
}

class _MultiLineTextFieldState extends State<MultiLineTextField> {
  final int maxLines = 4;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: new TextField(
        keyboardType: TextInputType.multiline,
        maxLines: maxLines,
        controller: widget.cookingListController,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: widget.labelText,
            errorText: widget.validateCookingList ? null : 'Enter something'),
      ),
    );
  }
}
