import 'package:auto_run/widgets/textwidgetsmall.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

const bacgroundColor = Color(0xFFE7ECEF);
Widget cardMorphism() {
  return Neumorphic(
      style: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
          depth: 8,
          lightSource: LightSource.topLeft,
          color: Colors.grey),
      child: textWidgets(text: 'Enjoy It'));
}
