import 'package:auto_run/core/const.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../controller/auth_controller.dart';

class profpic extends StatelessWidget {
  const profpic({
    Key? key,
    required this.authController,
  }) : super(key: key);

  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return NeumorphicFloatingActionButton(
      style: NeumorphicStyle(
        shadowDarkColor: bc,
        shadowLightColor: Colors.grey,
        color: NeumorphicColors.darkBackground,
        shape: NeumorphicShape.convex,
        boxShape: NeumorphicBoxShape.circle(),
      ),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: authController.myUser.value.image == null
                ? DecorationImage(
                    image: AssetImage('assets/person.png'), fit: BoxFit.cover)
                : DecorationImage(
                    image: NetworkImage(authController.myUser.value.image!),
                    fit: BoxFit.cover)),
      ),
    );
  }
}

class drawerBar extends StatelessWidget {
  const drawerBar({
    Key? key,
    required this.authController,
  }) : super(key: key);

  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      top: 50,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(blurRadius: 8, color: NeumorphicColors.darkBackground)
          ],
          border: Border.all(width: 4, color: NeumorphicColors.darkBackground),
          shape: BoxShape.circle,
        ),
        child: Builder(builder: (context) {
          return NeumorphicFloatingActionButton(
            style: NeumorphicStyle(
              shadowDarkColor: bc,
              shadowLightColor: Colors.grey,
              color: NeumorphicColors.darkBackground,
              shape: NeumorphicShape.convex,
              boxShape: NeumorphicBoxShape.circle(),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            child: Icon(
              EvaIcons.menu2Outline,
              color: yellow,
            ),
          );
          // IconButton(
          //   onPressed: () {
          //     Scaffold.of(context).openDrawer();
          //   },
          //   icon: const Icon(EvaIcons.menu2Outline),
          //   color: yellow,
          // );
        }),
      ),
    );
  }
}
