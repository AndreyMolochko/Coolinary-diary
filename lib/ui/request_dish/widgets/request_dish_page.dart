import 'package:flutter/material.dart';
import 'package:sqflite_worker/ui/request_dish/module.dart';

class RequestDishPage extends StatefulWidget {
  final RequestDishViewModelType _viewModel;

  RequestDishPage(this._viewModel);

  @override
  _RequestDishPageState createState() => _RequestDishPageState();
}

class _RequestDishPageState extends State<RequestDishPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget._viewModel.getPageTitle(context)),
        ),
        body: _buildBody());
  }

  Widget _buildBody() {
    return Text("body");
  }
}
