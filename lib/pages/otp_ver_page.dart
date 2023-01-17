import 'package:auto_run/controller/auth_controller.dart';
import 'package:auto_run/core/const.dart';
import 'package:auto_run/widgets/green_intro.dart';
import 'package:auto_run/widgets/otp_ver_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpVerificationScreen extends StatefulWidget {
  String phoneNumber;
  OtpVerificationScreen(this.phoneNumber);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    authController.phoneAuth(widget.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                greenIntroWidget(),
                Positioned(
                  top: 60,
                  left: 30,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: yellow,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            otpWidget(),
          ],
        ),
      ),
    );
  }
}
