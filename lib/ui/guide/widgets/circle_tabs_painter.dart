import 'package:flutter/cupertino.dart';
import 'package:sqflite_worker/resourses/module.dart';

class CircleTabsPainter extends CustomPainter {
  int position;
  double radiusLittleCircle = Dimens.radiusSmallCircleTab;
  double radiusBigCircle = Dimens.radiusBigCircleTab;
  double distanceBetweenCircles = Dimens.distanceBetweenCircleTabs;

  CircleTabsPainter(this.position);

  var painter = Paint()
    ..style = PaintingStyle.fill
    ..color = Colors.white
    ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Size size) {
    switch (position) {
      case 0:
        canvas.drawCircle(Offset(-distanceBetweenCircles, 0), radiusBigCircle, painter);
        canvas.drawCircle(Offset(0, 0), radiusLittleCircle, painter);
        canvas.drawCircle(Offset(distanceBetweenCircles, 0), radiusLittleCircle, painter);
        break;
      case 1:
        canvas.drawCircle(Offset(-distanceBetweenCircles, 0), radiusLittleCircle, painter);
        canvas.drawCircle(Offset(0, 0), radiusBigCircle, painter);
        canvas.drawCircle(Offset(distanceBetweenCircles, 0), radiusLittleCircle, painter);
        break;
      case 2:
        canvas.drawCircle(Offset(-distanceBetweenCircles, 0), radiusLittleCircle, painter);
        canvas.drawCircle(Offset(0, 0), radiusLittleCircle, painter);
        canvas.drawCircle(Offset(distanceBetweenCircles, 0), radiusBigCircle, painter);
        break;
    }

    canvas.save();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CircleTabsPainter oldDelegate) => oldDelegate.position != position;
}
