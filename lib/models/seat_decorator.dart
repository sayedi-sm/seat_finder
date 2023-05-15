import 'package:flutter/material.dart';

class SeatDecorator extends CustomPainter {
  final Color color;
  final bool isTop;
  final double strokeWidth;

  SeatDecorator({
    required this.color,
    required this.isTop,
    this.strokeWidth = 8,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = strokeWidth;

    Path path = Path();
    final double halfStrokeWidth = strokeWidth / 2;
    if (isTop) {
      path.moveTo(-halfStrokeWidth, size.height / 2);
      path.lineTo(-halfStrokeWidth, -halfStrokeWidth);
      path.lineTo(size.width + halfStrokeWidth, -halfStrokeWidth);
      path.lineTo(size.width + halfStrokeWidth, size.height / 2);
    } else {
      path.moveTo(-halfStrokeWidth, size.height / 2);
      path.lineTo(-halfStrokeWidth, size.height + halfStrokeWidth);
      path.lineTo(size.width + halfStrokeWidth, size.height + halfStrokeWidth);
      path.lineTo(size.width + halfStrokeWidth, size.height / 2);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
