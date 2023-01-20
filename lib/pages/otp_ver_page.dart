import 'dart:async';

import 'package:auto_run/controller/auth_controller.dart';
import 'package:auto_run/widgets/green_intro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/piputotp.dart';
import '../widgets/textwidgetsmall.dart';

class OtpVerificationScreen extends StatefulWidget {
  String phoneNumber;
  OtpVerificationScreen(this.phoneNumber);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  AuthController authController = Get.find<AuthController>();
  int _remainingTime = 60;
  @override
  void initState() {
    super.initState();
    authController.phoneAuth(widget.phoneNumber);
    _startCountdown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
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
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).indicatorColor,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWidgets(
                      text: 'Phone Verification',
                      color1: Theme.of(context).primaryColorDark),
                  textWidgets(
                    text: "Enter Your One Time Password\n(OTP)",
                    color1: Theme.of(context).primaryColorDark,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                      width: Get.width,
                      height: 50,
                      child: const RoundedWithShadow()),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: _remainingTime > 0 ? null : () => _resendOtp(),
                          child: Container(
                              height: 40,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10,
                                      offset: const Offset(10, 10),
                                      color: Theme.of(context).splashColor,
                                    ),
                                    BoxShadow(
                                      blurRadius: 10,
                                      offset: const Offset(-10, -10),
                                      color: Theme.of(context).shadowColor,
                                    ),
                                  ]),
                              child: Center(
                                  child: _remainingTime > 0
                                      ? textWidgets(
                                          text: "Resend  $_remainingTime ",
                                          color1: Theme.of(context)
                                              .primaryColorDark)
                                      : textWidgets(
                                          text: 'Resend',
                                          color1: Theme.of(context)
                                              .indicatorColor))),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startCountdown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  void _resendOtp() async {
    authController.phoneAuth(widget.phoneNumber);
    _remainingTime = 60;
    _startCountdown();
  }
}
