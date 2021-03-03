import 'package:flutter/material.dart';
import 'package:sqflite_worker/localization/app_translations.dart';

import '../module.dart';

class AddDishPhotoPage extends StatefulWidget {
  final RequestDishViewModelType _viewModel;

  AddDishPhotoPage(this._viewModel);

  @override
  _AddDishPhotoPageState createState() => _AddDishPhotoPageState();
}

class _AddDishPhotoPageState extends State<AddDishPhotoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget._viewModel.getPageTitle(context)),
        ),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        _buildSaveButton(context)
      ],
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        child: Text(AppTranslations.of(context).text('add_dish_photo_screen_save_button')),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
