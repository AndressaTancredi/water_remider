import 'dart:math';

import 'package:flutter/material.dart';

class WaterPainter extends CustomPainter {
  final double progress;

  WaterPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final wavePath = Path();
    const waveHeight = 20.0;
    const waveFrequency = 2.5;

    double waveProgress =
        progress * size.height / (size.height + kToolbarHeight);
    wavePath.moveTo(0, size.height * (1 - waveProgress));
    for (double i = 0; i <= size.width; i++) {
      wavePath.lineTo(
        i,
        size.height * (1 - waveProgress) +
            waveHeight *
                sin((i / size.width * 2 * pi) * waveFrequency +
                    progress * 2 * pi),
      );
    }
    wavePath.lineTo(size.width, size.height + kToolbarHeight);
    wavePath.lineTo(0, size.height + kToolbarHeight);
    wavePath.close();

    canvas.drawPath(wavePath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
