import 'package:flutter/material.dart';
import 'dart:core';

class CustomProgress extends StatefulWidget {
  @override
  _CustomProgressState createState() => _CustomProgressState();
}

class _CustomProgressState extends State<CustomProgress> with SingleTickerProviderStateMixin {
  double progress = 78;
  double drawingProgress = 0;

  AnimationController controller;
  Animation animation;


  @override
  void initState() {
    controller = new AnimationController(vsync: this,duration: const Duration
      (milliseconds: 1000)
    )..repeat();
    animation = Tween(begin: 0.0, end:progress).animate(controller);
    controller.addListener((){
      print(animation.value);
      if(animation.value>progress-2){
        setState(() {
          print(animation.value);
          controller.stop();
          drawingProgress=progress;
        });
      }else {
        setState(() {
          drawingProgress = animation.value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: new AppBar(
          title: new Text("CustomProgress"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    new CustomPaint(
                      painter: GraphicPainter(drawingProgress),
                    ),
                    new Text((drawingProgress.round().toString() + "%"),
                      style: new
                    TextStyle
                      (fontWeight:  FontWeight.bold,color: Colors.white,
                        fontSize: 28.0),)
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}

class GraphicPainter extends CustomPainter {
  double percent;
  double onePercentInRadian = 0.0628319;
  double startPercentsInRadian = -1.5708;
  double radius = 50.0;

  GraphicPainter(this.percent);

  var paintLowProgress = new Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.white
    ..isAntiAlias = true
    ..strokeWidth = 3;

  var paintHighProgress = new Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.yellow
    ..isAntiAlias = true
    ..strokeWidth = 6;

  @override
  void paint(Canvas canvas, Size size) {

    var centerCircle = new Offset(0, 0);
    canvas.drawCircle(centerCircle, radius, paintLowProgress);

    var rect = Rect.fromCircle(center: centerCircle, radius: radius);
    canvas.drawArc(rect, startPercentsInRadian, percent * onePercentInRadian,
        false, paintHighProgress);
    canvas.save();
    canvas.restore();
  }

  @override
  bool shouldRepaint(GraphicPainter oldDelegate) {
    return oldDelegate.percent != percent;
  }
}
