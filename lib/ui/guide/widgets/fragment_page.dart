import 'package:flutter/material.dart';
import 'package:sqflite_worker/resourses/module.dart';

class FragmentPage extends StatelessWidget {
  final String imagePath;
  final String text;

  const FragmentPage({Key key, this.imagePath, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBody(context, imagePath, text);
  }

  Widget _buildBody(BuildContext context, String imagePath, String text) {
    return Material(
      child: Container(
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage(imagePath),
              width: Dimens.sizeImageGuidePage,
              height: Dimens.sizeImageGuidePage,
            ),
            Padding(
              padding: const EdgeInsets.only(top: Dimens.bigPadding),
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: Dimens.mediumFontSize),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
