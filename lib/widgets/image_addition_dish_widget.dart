import 'dart:io';

import 'package:flutter/material.dart';

class ImageNewDish extends StatefulWidget {
  final File image;
  final void Function() onPressed;

  const ImageNewDish({this.image, this.onPressed});

  @override
  _ImageNewDishState createState() => _ImageNewDishState();
}

class _ImageNewDishState extends State<ImageNewDish> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: widget.image == null
          ? new Icon(Icons.image)
          : new Image.file(widget.image),
      onPressed: () {
        widget.onPressed();
      },
      iconSize: 48,
    );
  }
}
