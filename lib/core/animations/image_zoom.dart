import 'package:flutter/material.dart';

class AnimatedZoomImage extends StatefulWidget {
  final Widget child;
  final double? zoomScale;
  const AnimatedZoomImage({super.key, required this.child, this.zoomScale});

  @override
  State<AnimatedZoomImage> createState() => _AnimatedZoomImageState();
}

class _AnimatedZoomImageState extends State<AnimatedZoomImage> {
  bool _isHovered = false;

  void _mouseEnter(bool hover) {
    setState(() {
      _isHovered = hover;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _mouseEnter(true),
      onExit: (_) => _mouseEnter(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        transform: Matrix4.identity()
          ..scale(_isHovered ? widget.zoomScale ?? 1.1 : 1.0),
        transformAlignment: Alignment.center,
        child: widget.child,
      ),
    );
  }
}
