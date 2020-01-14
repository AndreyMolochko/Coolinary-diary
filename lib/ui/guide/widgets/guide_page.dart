import 'package:flutter/material.dart';
import 'package:sqflite_worker/ui/guide/module.dart';

class GuidePage extends StatefulWidget {
  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  int _indexCurrentPage = 0;

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: <Widget>[
        PageView(
          onPageChanged: _onPageViewChange,
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
        ),
        _buildCircleTabs()
      ],
    );
  }

  Widget _buildCircleTabs() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center, //doesn't work
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: CustomPaint(
                painter: CircleTabsPainter(_indexCurrentPage),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _onPageViewChange(int page) {
    setState(() {
      _indexCurrentPage = page;
    });
  }
}
