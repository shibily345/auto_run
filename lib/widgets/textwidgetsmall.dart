import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

Widget textWidgets(
    {required String text,
    double fontSize1 = 15,
    FontWeight fontWeight1 = FontWeight.normal,
    Color color1 = Colors.black}) {
  return Text(
    text,
    style: GoogleFonts.poppins(
        fontSize: fontSize1, fontWeight: fontWeight1, color: color1),
  );
}
