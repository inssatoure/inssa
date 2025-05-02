import 'package:flutter/material.dart';

void webPrint(dynamic value) {
  debugPrint(value.toString());
}

int timeNow() {
  return DateTime.now().millisecondsSinceEpoch;
}
