import 'package:flutter/material.dart';
import 'package:sqflite_worker/localization/app_translations.dart';
import 'package:sqflite_worker/ui/guide/module.dart';

class GuidePage extends StatefulWidget {

  final GuideViewModelType _viewModel;

  const GuidePage(this._viewModel);
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
              text: AppTranslations.translate(context, "guide_screen_add_recipes"),
            ),
            FragmentPage(
              imagePath: 'assets/cooking.png',
              text: AppTranslations.translate(context, "guide_screen_cooking"),
            ),
            FragmentPage(
              imagePath: 'assets/dishes_list.png',
              text: AppTranslations.translate(context, "guide_screen_browse_other_recipes"),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            _buildOkButton(),
            _buildCircleTabs(),
          ],
        )
      ],
    );
  }

  Widget _buildCircleTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
          child: CustomPaint(
            painter: CircleTabsPainter(_indexCurrentPage),
          ),
        ),
      ],
    );
  }

  Widget _buildOkButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0, right: 32.0),
      child: Container(
        width: double.maxFinite,
        child: RaisedButton(
          color: Colors.black,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0), side: BorderSide(color: Colors.white)),
          onPressed: () {
            widget._viewModel.continueButtonAction(context);
          },
          child: Text(AppTranslations.translate(context, "guide_screen_continue")),
        ),
      ),
    );
  }

  _onPageViewChange(int page) {
    setState(() {
      _indexCurrentPage = page;
    });
  }
}
