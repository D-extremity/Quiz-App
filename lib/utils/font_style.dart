import 'dart:ui';

import 'package:flutter/material.dart';

const FontWeight fb = FontWeight.bold;
const FontWeight f4 = FontWeight.w400;
FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
Size size = view.physicalSize;
Text getText(
    {required String s, required double size, FontWeight? fw, Color? color}) {
  return Text(
    s,
    style: TextStyle(
        color: color ?? const Color.fromARGB(255, 72, 72, 72),
        fontSize: size,
        fontWeight: fw ?? f4),
  );
}
