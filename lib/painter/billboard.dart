import 'package:flutter/material.dart';

class CustomLine extends StatelessWidget {
  const CustomLine({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CustomLinePainter(),
      size: const Size(10, 20), // Adjust the size as needed
    );
  }
}

class _CustomLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.grey // Change the color as desired
      ..strokeWidth = 2;

    final double centerX = size.width / 2;
    const double lineStartY = 0;
    final double lineEndY = size.height; // Adjust the line length as needed

    final Rect rectangle = Rect.fromCenter(
      center: Offset(centerX, size.height - 5 / 2),
      width: 10,
      height: 5,
    );


    // Draw the line
    canvas.drawLine(
        Offset(centerX, lineStartY), Offset(centerX, lineEndY), paint);

    // Draw the circle
    //  canvas.drawCircle(Offset(centerX, size.height), circleRadius, paint);

    canvas.drawRect(rectangle, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // Since this is a static drawing, we don't need to repaint
  }
}
