import 'package:flutter/material.dart';
import 'package:saloon_app/utilities/utilities.dart';

class CustomRoundSliderThumbShape extends SliderComponentShape {
  final Color backgroundColor;
  final String distanceText;
  const CustomRoundSliderThumbShape({
    this.backgroundColor,
    this.distanceText,
    this.enabledThumbRadius = 10.0,
    this.disabledThumbRadius,
  });

  final double enabledThumbRadius;

  final double disabledThumbRadius;
  double get _disabledThumbRadius => disabledThumbRadius ?? enabledThumbRadius;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(
        isEnabled == true ? enabledThumbRadius : _disabledThumbRadius);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {Animation<double> activationAnimation,
      Animation<double> enableAnimation,
      bool isDiscrete,
      TextPainter labelPainter,
      RenderBox parentBox,
      SliderThemeData sliderTheme,
      TextDirection textDirection,
      double value,
      double textScaleFactor,
      Size sizeWithOverflow}) {
    assert(sliderTheme.disabledThumbColor != null);
    assert(sliderTheme.thumbColor != null);

    final Canvas canvas = context.canvas;

    /// Draw hand with background color
    final Tween<double> radiusTween = Tween<double>(
      begin: _disabledThumbRadius * 0.7,
      end: enabledThumbRadius * 0.7,
    );

    /// Draw hand border with primary Color
    final Tween<double> radiusTween2 = Tween<double>(
      begin: _disabledThumbRadius * 1.2,
      end: enabledThumbRadius * 1.2,
    );

    /// primary Color for hand
    final ColorTween colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );

    Path path = Path();
    final double height = center.dy;
    final double width = center.dx;
    path.moveTo(width - 25, height + 7);
    path.lineTo(width - 13, height + 7);
    path.quadraticBezierTo(width, height + 23, width + 13, height + 7);
    path.lineTo(width + 25, height + 7);
    path.quadraticBezierTo(width + 30, height + 7, width + 30, height + 12);
    path.lineTo(width + 30, height + 42);
    path.quadraticBezierTo(width + 30, height + 47, width + 25, height + 47);
    path.lineTo(width - 25, height + 47);
    path.quadraticBezierTo(width - 30, height + 47, width - 30, height + 42);
    path.lineTo(width - 30, height + 12);
    path.quadraticBezierTo(width - 30, height + 7, width - 25, height + 7);

    TextPainter text = TextPainter(
      text: TextSpan(
        text: distanceText,
        style: FontStyleUtilities.p3(
          fontColor: ColorUtilities.white,
          fontWeight: FWT.semiBold,
        ),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );

    /// draw hand border
    canvas.drawCircle(
      center,
      radiusTween2.evaluate(enableAnimation),
      Paint()..color = colorTween.evaluate(enableAnimation),
    );

    /// draw hand inner
    canvas.drawCircle(
      center,
      radiusTween.evaluate(enableAnimation),
      Paint()..color = backgroundColor,
    );

    canvas.drawPath(
        path,
        Paint()
          ..color = colorTween.evaluate(enableAnimation)
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round);
    text.layout();
    text.paint(canvas, Offset(width - 18, height + 22));
  }
}
