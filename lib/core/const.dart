import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

const bigspace = SizedBox(
  height: 30,
);
const litlespace = SizedBox(
  height: 15,
);
const White = Colors.white;
const yellow = Colors.amber;
const bc = Colors.black;
String apikey = "AIzaSyBEh1TK5IbinaixvHUcB4_b1AHKwWrkuic";
String firebaseapi = "AIzaSyAlNRVC4CfAePVFx6ivigL7qHtU6orPTu8";

const NeumorphicStyle nmstylebtn = NeumorphicStyle(
  shadowDarkColor: bc,
  shadowLightColor: Colors.grey,
  color: NeumorphicColors.darkBackground,
  shape: NeumorphicShape.convex,
  boxShape: NeumorphicBoxShape.circle(),
);
