import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:ifafu/http/model.dart';

class ScoreChartPainter extends CustomPainter {
  final List<Score> scores;
  final colors = [
    const Color(0xFF89B6B9),
    const Color(0xFFfcb1b1),
    const Color(0xFF9DDCDC),
    const Color(0xFFAAD9FF),
    const Color(0xFFFFB53B),
    const Color(0xFF5acfd6),
  ];

  ScoreChartPainter(this.scores);

  final Paint _paint = Paint()
    ..strokeCap = StrokeCap.round //画笔笔触类型
    ..isAntiAlias = true //是否启动抗锯齿
    ..strokeWidth = 2.0; //画笔的宽度

  @override
  void paint(Canvas canvas, Size size) {
    final perWidth = size.width / scores.length;
    final start = perWidth / 2;

    Offset? lastPoint;
    Color? lastColor;
    for (int i = 0; i < scores.length; i++) {
      final y = size.height * (1 - scores[i].score / 100);
      final p = Offset(start + perWidth * i, y);
      final color = colors[i % colors.length];
      // canvas.drawCircle(p, 2, _paint);
      if (lastPoint != null && lastColor != null) {
        _paint.shader = ui.Gradient.linear(
          lastPoint,
          p,
          [lastColor, color],
        );
        canvas.drawLine(lastPoint, p, _paint);
      }
      lastPoint = p;
      lastColor = color;
    }
    _paint.shader = null;
    for (int i = 0; i < scores.length; i++) {
      final y = size.height * (1 - scores[i].score / 100);
      final p = Offset(start + perWidth * i, y);
      _paint.color = colors[i % colors.length];
      canvas.drawCircle(p, 2, _paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
