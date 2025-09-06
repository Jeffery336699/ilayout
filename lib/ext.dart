import 'package:flutter/material.dart';

/// Widget 扩展方法
extension WidgetExtension on Widget {
  /// 为 Widget 添加边框
  ///
  /// [color] 边框颜色，默认为灰色
  /// [width] 边框宽度，默认为 1.0
  /// [radius] 圆角半径，默认为 0（无圆角）
  /// [style] 边框样式，默认为实线
  Widget border({
    Color color = Colors.green,
    double width = 1.0,
    double radius = 0.0,
    BorderStyle style = BorderStyle.solid,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
          width: width,
          style: style,
        ),
        borderRadius: radius > 0 ? BorderRadius.circular(radius) : null,
      ),
      child: this,
    );
  }

  /// 为 Widget 添加自定义边框
  ///
  /// [border] 自定义的 Border 对象
  /// [borderRadius] 自定义的 BorderRadius 对象
  Widget customBorder({
    Border? border,
    BorderRadius? borderRadius,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: border,
        borderRadius: borderRadius,
      ),
      child: this,
    );
  }

  /// 为 Widget 添加圆形边框
  ///
  /// [color] 边框颜色，默认为灰色
  /// [width] 边框宽度，默认为 1.0
  Widget circleBorder({
    Color color = Colors.grey,
    double width = 1.0,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
          width: width,
        ),
        shape: BoxShape.circle,
      ),
      child: this,
    );
  }

  /// 为 Widget 添加虚线边框
  ///
  /// [color] 边框颜色，默认为灰色
  /// [width] 边框宽度，默认为 1.0
  /// [dashWidth] 虚线段长度，默认为 5.0
  /// [dashSpace] 虚线间隔，默认为 3.0
  /// [radius] 圆角半径，默认为 0
  Widget dashedBorder({
    Color color = Colors.grey,
    double width = 1.0,
    double dashWidth = 5.0,
    double dashSpace = 3.0,
    double radius = 0.0,
  }) {
    return CustomPaint(
      painter: DashedBorderPainter(
        color: color,
        strokeWidth: width,
        dashWidth: dashWidth,
        dashSpace: dashSpace,
        radius: radius,
      ),
      child: this,
    );
  }

  /// 为 Widget 添加阴影边框
  ///
  /// [color] 边框颜色，默认为灰色
  /// [width] 边框宽度，默认为 1.0
  /// [shadowColor] 阴影颜色，默认为黑色透明
  /// [blurRadius] 模糊半径，默认为 4.0
  /// [offset] 阴影偏移，默认为 (0, 2)
  /// [radius] 圆角半径，默认为 0
  Widget shadowBorder({
    Color color = Colors.grey,
    double width = 1.0,
    Color shadowColor = const Color(0x1F000000),
    double blurRadius = 4.0,
    Offset offset = const Offset(0, 2),
    double radius = 0.0,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
          width: width,
        ),
        borderRadius: radius > 0 ? BorderRadius.circular(radius) : null,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: blurRadius,
            offset: offset,
          ),
        ],
      ),
      child: this,
    );
  }

  /// 为 Widget 添加渐变边框
  ///
  /// [gradient] 渐变对象
  /// [width] 边框宽度，默认为 2.0
  /// [radius] 圆角半径，默认为 0
  Widget gradientBorder({
    required Gradient gradient,
    double width = 2.0,
    double radius = 0.0,
  }) {
    return CustomPaint(
      painter: GradientBorderPainter(
        gradient: gradient,
        strokeWidth: width,
        radius: radius,
      ),
      child: this,
    );
  }
}

/// 虚线边框绘制器
class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double radius;

  const DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path();

    if (radius > 0) {
      path.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(radius),
      ));
    } else {
      path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    }

    _drawDashedPath(canvas, path, paint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    final pathMetrics = path.computeMetrics();

    for (final pathMetric in pathMetrics) {
      double distance = 0.0;
      bool draw = true;

      while (distance < pathMetric.length) {
        final length = draw ? dashWidth : dashSpace;
        final segment = pathMetric.extractPath(
          distance,
          distance + length,
        );

        if (draw) {
          canvas.drawPath(segment, paint);
        }

        distance += length;
        draw = !draw;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 渐变边框绘制器
class GradientBorderPainter extends CustomPainter {
  final Gradient gradient;
  final double strokeWidth;
  final double radius;

  const GradientBorderPainter({
    required this.gradient,
    required this.strokeWidth,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    if (radius > 0) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(radius)),
        paint,
      );
    } else {
      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
