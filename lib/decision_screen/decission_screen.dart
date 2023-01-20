import 'package:auto_run/core/const.dart';
import 'package:auto_run/widgets/textwidgetsmall.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';
import '../pages/login_screen.dart';
import '../widgets/green_intro.dart';
import '../widgets/my_button.dart';

class DecisionScreen extends StatelessWidget {
  DecisionScreen({Key? key}) : super(key: key);

  AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              greenIntroWidget(),
              bigspace,
              textWidgets(
                  text: 'Welcome...!',
                  fontSize1: 30,
                  fontWeight1: FontWeight.w400,
                  color1: Theme.of(context).primaryColorDark),
              const SizedBox(
                height: 50,
              ),
              DecisionButton(
                  context, Icons.local_taxi_rounded, 'Login As Driver', () {
                authController.isLoginAsDriver = true;
                Get.to(() => const LoginPage());
              }, Get.width * 0.8),
              const SizedBox(
                height: 30,
              ),
              DecisionButton(context, Icons.person, 'Login As User', () {
                authController.isLoginAsDriver = false;
                Get.to(() => const LoginPage());
              }, Get.width * 0.8),
              bigspace,
              bigspace,
              textWidgets(
                  text: 'SHIBIL CREATIONS ', color1: Colors.grey, fontSize1: 10)
            ],
          ),
        ),
      ),
    );
  }
}
