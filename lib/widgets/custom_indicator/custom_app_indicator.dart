import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:quick_resume_creator/core/colors/app_colors.dart';

const double _kDefaultIndicatorRadius = 10.0;

/// An iOS-style activity indicator.

class CupertinoCustomActivityIndicator extends StatefulWidget {
  /// Creates an iOS-style activity indicator.
  const CupertinoCustomActivityIndicator({
    super.key,
    this.animating = true,
    this.radius = _kDefaultIndicatorRadius,
  }) : assert(radius > 0);

  final bool animating;

  final double radius;

  @override
  // ignore: library_private_types_in_public_api
  _CupertinoCustomActivityIndicatorState createState() =>
      _CupertinoCustomActivityIndicatorState();
}

class _CupertinoCustomActivityIndicatorState
    extends State<CupertinoCustomActivityIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    if (widget.animating) _controller!.repeat();
  }

  @override
  void didUpdateWidget(CupertinoCustomActivityIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animating != oldWidget.animating) {
      if (widget.animating) {
        _controller!.repeat();
      } else {
        _controller!.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.radius * 5,
      width: widget.radius * 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CustomPaint(
            painter: _CupertinoCustomActivityIndicatorPainter(
              position: _controller!,
              radius: widget.radius,
            ),
          ),
        ],
      ),
    );
  }
}

const double _kTwoPI = math.pi * 2.0;
const int _kTickCount = 12;
const int _kHalfTickCount = _kTickCount ~/ 2;
const Color _kTickColor = CupertinoColors.lightBackgroundGray;
Color _kActiveTickColor = AppColors.text_color_black;

class _CupertinoCustomActivityIndicatorPainter extends CustomPainter {
  _CupertinoCustomActivityIndicatorPainter({
    this.position,
    double? radius,
  })  : tickFundamentalRRect = RRect.fromLTRBXY(
          -radius!,
          1.0 * radius / _kDefaultIndicatorRadius,
          -radius / 2.0,
          -1.0 * radius / _kDefaultIndicatorRadius,
          1.0,
          1.0,
        ),
        super(repaint: position);

  final Animation<double>? position;
  final RRect tickFundamentalRRect;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();

    canvas.save();
    canvas.translate(size.width / 2.0, size.height / 2.0);

    final int activeTick = (_kTickCount * position!.value).floor();

    for (int i = 0; i < _kTickCount; ++i) {
      final double t =
          (((i + activeTick) % _kTickCount) / _kHalfTickCount).clamp(0.0, 1.0);
      paint.color = Color.lerp(_kActiveTickColor, _kTickColor, t)!;
      canvas.drawRRect(tickFundamentalRRect, paint);
      canvas.rotate(-_kTwoPI / _kTickCount);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(_CupertinoCustomActivityIndicatorPainter oldPainter) {
    return oldPainter.position != position;
  }
}
