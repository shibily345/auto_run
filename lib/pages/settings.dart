import 'package:auto_run/core/const.dart';
import 'package:auto_run/widgets/textwidgetsmall.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

import '../widgets/theme_change_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          textWidgets(
              text: "Mode Switch Button",
              color1: Theme.of(context).primaryColorDark,
              fontSize1: 20),
          bigspace,
          bigspace,
          Center(
            child: NeumorphicFloatingActionButton(
              style: NeumorphicStyle(
                shadowDarkColor: Theme.of(context).splashColor,
                shadowLightColor: Theme.of(context).shadowColor,
                color: Theme.of(context).primaryColor,
                shape: NeumorphicShape.convex,
                boxShape: const NeumorphicBoxShape.circle(),
              ),
              onPressed: () {
                Get.back();
              },
              child: const Center(
                child: ChangeThemeButton(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
