import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;

class PDFFonts {
  ///Jost
  static Future<pw.Font> jost() async {
    final fontData =
        await rootBundle.load('assets/fonts/jost/Jost-Regular.ttf');
    return pw.Font.ttf(fontData.buffer.asByteData());
  }

  static Future<pw.Font> jostSemiBold() async {
    final fontData =
        await rootBundle.load('assets/fonts/jost/Jost-SemiBold.ttf');
    return pw.Font.ttf(fontData.buffer.asByteData());
  }

  ///Hind
  static Future<pw.Font> hind() async {
    final fontData =
        await rootBundle.load('assets/fonts/hind/Hind-Regular.ttf');
    return pw.Font.ttf(fontData.buffer.asByteData());
  }

  static Future<pw.Font> hindMedium() async {
    final fontData = await rootBundle.load('assets/fonts/hind/Hind-Medium.ttf');
    return pw.Font.ttf(fontData.buffer.asByteData());
  }

  static Future<pw.Font> hindSemiBold() async {
    final fontData =
        await rootBundle.load('assets/fonts/hind/Hind-SemiBold.ttf');
    return pw.Font.ttf(fontData.buffer.asByteData());
  }

  ///IBM Plex Sans
  static Future<pw.Font> ibmPlexSans() async {
    final fontData = await rootBundle
        .load('assets/fonts/ibm_plex_sans/IBMPlexSans-Regular.ttf');
    return pw.Font.ttf(fontData.buffer.asByteData());
  }

  static Future<pw.Font> ibmPlexSansSemiBold() async {
    final fontData = await rootBundle
        .load('assets/fonts/ibm_plex_sans/IBMPlexSans-SemiBold.ttf');
    return pw.Font.ttf(fontData.buffer.asByteData());
  }

  static Future<pw.Font> ibmPlexSansBold() async {
    final fontData = await rootBundle
        .load('assets/fonts/ibm_plex_sans/IBMPlexSans-Bold.ttf');
    return pw.Font.ttf(fontData.buffer.asByteData());
  }

  ///Source Serif 4
  static Future<pw.Font> sourceSerif4() async {
    final fontData = await rootBundle
        .load('assets/fonts/source_serif_4/SourceSerif4-Regular.ttf');
    return pw.Font.ttf(fontData.buffer.asByteData());
  }

  static Future<pw.Font> sourceSerif4SemiBold() async {
    final fontData = await rootBundle
        .load('assets/fonts/source_serif_4/SourceSerif4-SemiBold.ttf');
    return pw.Font.ttf(fontData.buffer.asByteData());
  }
}
