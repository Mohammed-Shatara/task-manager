import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderPainter extends CustomPainter {
  final double height;
  final Color? color;
  final Color? start;
  final Color? end;

  HeaderPainter({this.height = 238, this.color, this.start, this.end});

  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;

    var paint = Paint()..strokeWidth = 25.0;
    if (color != null) {
      paint.color = color!;
    }

    paint.shader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: const [0.5, 1],
      colors: [
        start ?? const Color(0xff2C4D75), //LightModeColors().primary40,
        end ?? const Color(0xff157D9E) //,LightModeColors().secondary40,
      ],
    ).createShader(rect);

    paint.style = PaintingStyle.fill;

    final path = Path();

    double height = this.height.h;

    path.lineTo(0, height);

    path.quadraticBezierTo(5, height - 110, 160, height - 110);
    path.lineTo(size.width - 140, height - 110);
    path.quadraticBezierTo(
        size.width - 10, height - 110, size.width, height - 195);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(HeaderPainter oldDelegate) {
    return false; // oldDelegate.color != color;
  }
}
