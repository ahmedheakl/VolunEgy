import "package:flutter/material.dart";
import "package:volun/utils/globals.dart";
import 'package:google_fonts_arabic/fonts.dart';

Widget getLogo(double size, {Color color = Colors.red}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(appName,
          textDirection: TextDirection.rtl,
          style: TextStyle(
              color: color,
              fontSize: size,
              fontWeight: FontWeight.bold,
              fontFamily: ArabicFonts.Cairo,
              package: "google_fonts_arabic")),
      Container(
          padding: const EdgeInsets.only(top: 5.0),
          child: Icon(
            Icons.spa_outlined,
            color: Colors.green,
            size: (size * (35 / 30)),
          )),
    ],
  );
}

Widget getTitle(String title,
    {double size = 25.0, Color color = Colors.white}) {
  return Text(title,
      textDirection: TextDirection.rtl,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold,
      ));
}
