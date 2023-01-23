import 'package:auto_run/core/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textWidget(
    {required String text,
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.normal,
    Color color = bc}) {
  return Text(
    text,
    style: GoogleFonts.poppins(
        fontSize: fontSize, fontWeight: fontWeight, color: color),
  );
}
