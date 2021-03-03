import 'package:flutter/material.dart';

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
        body: Container());
  }
}
