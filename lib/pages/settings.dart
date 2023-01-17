import 'package:auto_run/core/const.dart';
import 'package:auto_run/pages/home_screen..dart';
import 'package:auto_run/widgets/textwidgetsmall.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: NeumorphicFloatingActionButton(
          style: nmstylebtn,
          onPressed: () {
            Get.back();
          },
          child: Center(
            child: NeumorphicIcon(
              Icons.power_settings_new_sharp,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}
