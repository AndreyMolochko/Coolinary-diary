import 'package:flutter/material.dart';

class FragmentPage extends StatefulWidget {
  final String imagePath;
  final String text;

  const FragmentPage({Key key, this.imagePath, this.text}) : super(key: key);

  @override
  _FragmentPageState createState() => _FragmentPageState();
}

class _FragmentPageState extends State<FragmentPage> {
  @override
  Widget build(BuildContext context) {
    return _buildBody(context, widget.imagePath, widget.text);
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
              width: 200,
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
