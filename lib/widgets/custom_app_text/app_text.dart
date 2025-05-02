import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontsize;
  final FontWeight? fontWeight;
  final double? wordspace;
  final bool textCenter;
  final dynamic foreground;
  final double? laterspacing;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final TextAlign? textAlign;
  final double? height;

  const AppText({
    Key? key,
    required this.text,
    this.color,
    this.fontsize,
    this.fontWeight,
    this.wordspace,
    this.laterspacing,
    this.decoration,
    this.foreground,
    this.style,
    this.maxLines,
    this.overflow,
    this.textCenter = false,
    this.textAlign,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow ?? TextOverflow.clip,
      maxLines: maxLines,
      textAlign: textCenter ? TextAlign.center : textAlign,
      style: style ??
          GoogleFonts.jost(
            height: height,
            letterSpacing: laterspacing,
            color: color,
            fontSize: fontsize,
            fontWeight: fontWeight,
            wordSpacing: wordspace,
            decoration: decoration,
            foreground: foreground,
          ),
    );
  }
}
