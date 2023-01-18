import 'package:auto_run/core/const.dart';
import 'package:auto_run/widgets/textwidgetsmall.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';
import '../driver/profile_setup.dart';
import '../pages/login_screen.dart';
import '../widgets/green_intro.dart';
import '../widgets/my_button.dart';

class DecisionScreen extends StatelessWidget {
  DecisionScreen({Key? key}) : super(key: key);

  AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: nbcb,
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            greenIntroWidget(),
            bigspace,
            textWidget(
                text: 'Welcome...!',
                fontSize1: 30,
                fontWeight1: FontWeight.w400,
                color1: Colors.grey),
            const SizedBox(
              height: 50,
            ),
            DecisionButton('assets/driver.png', 'Login As Driver', () {
              authController.isLoginAsDriver = true;
              Get.to(() => LoginPage());
            }, Get.width * 0.8),
            const SizedBox(
              height: 30,
            ),
            DecisionButton('assets/customer.png', 'Login As User', () {
              authController.isLoginAsDriver = false;
              Get.to(() => LoginPage());
            }, Get.width * 0.8),
            bigspace,
            bigspace,
            textWidget(
                text: 'SHIBIL CREATIONS ', color1: Colors.grey, fontSize1: 10)
          ],
        ),
      ),
    );
  }
}
