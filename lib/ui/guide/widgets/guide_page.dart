import 'package:flutter/material.dart';
import 'package:sqflite_worker/ui/guide/module.dart';

class GuidePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return PageView(
      children: <Widget>[
        FragmentPage(
          imagePath: 'assets/add_receipts.png',
          text: 'Add receipts',
        ),
        FragmentPage(
          imagePath: 'assets/cooking.png',
          text: 'Cooking',
        ),
        FragmentPage(
          imagePath: 'assets/dishes_list.png',
          text: 'Look other receipts',
        ),
      ],
    );
  }
}
