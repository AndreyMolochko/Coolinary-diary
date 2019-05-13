import 'package:flutter/material.dart';

class CameraAlertDialog extends StatelessWidget {
  final String titleCamera;
  final String titleGallery;
  final void Function() onPressedCamera;
  final void Function() onPressedGallery;

  const CameraAlertDialog(this.titleCamera, this.titleGallery,
      this.onPressedCamera, this.onPressedGallery);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InkWell(
              onTap: onPressedCamera,
              child: _getElementAlertDialog(titleCamera)
          ),
          InkWell(
            onTap: onPressedGallery,
            child: _getElementAlertDialog(titleGallery)
          )
        ],
      ),
    );
  }

  Widget _getElementAlertDialog(String title) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child:
          Text(title, style: new TextStyle(fontSize: 18.0)),
        ),
      ],
    );
  }
}
