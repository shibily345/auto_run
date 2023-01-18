import 'package:eva_icons_flutter/eva_icons_flutter.dart';
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
        shadowDarkColor: Theme.of(context).splashColor,
        shadowLightColor: Theme.of(context).shadowColor,
        color: Theme.of(context).primaryColor,
        shape: NeumorphicShape.convex,
        boxShape: const NeumorphicBoxShape.circle(),
      ),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: authController.myUser.value.image == null
                ? const DecorationImage(
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
      child: Builder(builder: (context) {
        return NeumorphicFloatingActionButton(
          style: NeumorphicStyle(
            shadowDarkColor: Theme.of(context).shadowColor,
            shadowLightColor: Theme.of(context).primaryColor,
            color: Theme.of(context).primaryColor,
            shape: NeumorphicShape.convex,
            boxShape: const NeumorphicBoxShape.circle(),
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          child: Icon(
            color: Theme.of(context).indicatorColor,
            EvaIcons.menu2Outline,
          ),
        );
      }),
    );
  }
}
