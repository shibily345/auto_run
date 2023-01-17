import 'package:auto_run/core/const.dart';
import 'package:auto_run/pages/otp_ver_page.dart';
import 'package:auto_run/widgets/green_intro.dart';
import 'package:auto_run/widgets/login_widget.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final counntryPicker = const FlCountryCodePicker();
  CountryCode countryCode =
      CountryCode(name: 'India', code: "IN", dialCode: "+91");
  onSubmit(String? input) {
    Get.to(() => OtpVerificationScreen(countryCode.dialCode + input!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          height: Get.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              greenIntroWidget(),
              bigspace,
              loginWidget(countryCode, () async {
                final code = await counntryPicker.showPicker(context: context);
                if (code != null) countryCode = code;
                setState(() {});
              }, onSubmit),
            ],
          ),
        ),
      ),
    );
  }
}
