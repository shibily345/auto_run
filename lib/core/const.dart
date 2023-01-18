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
const nbcb = NeumorphicColors.darkBackground;
const grey = Colors.grey;
const shadowD = Color.fromARGB(79, 0, 0, 0);
const shadowL = Color.fromARGB(32, 131, 128, 128);
const selectyellow = Color.fromARGB(69, 255, 193, 7);
const nbcl = NeumorphicColors.background;

class MyThemes {
  static final darkTheme = ThemeData(
    primaryColorDark: Colors.grey,
    primaryColor: nbcb,
    primarySwatch: yellow,
    indicatorColor: Colors.amber,
    splashColor: const Color.fromARGB(79, 0, 0, 0),
    shadowColor: const Color.fromARGB(32, 131, 128, 128),
  );
  static final lightTheme = ThemeData(
      primaryColorDark: Colors.black,
      primaryColor: nbcl,
      primarySwatch: yellow,
      indicatorColor: const Color.fromARGB(255, 9, 7, 2),
      splashColor: const Color.fromARGB(79, 126, 124, 124),
      shadowColor: const Color.fromARGB(181, 251, 250, 250));
}
