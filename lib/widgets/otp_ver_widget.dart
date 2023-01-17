import 'package:auto_run/core/const.dart';
import 'package:auto_run/pages/otp_ver_page.dart';
import 'package:auto_run/widgets/piputotp.dart';
import 'package:auto_run/widgets/textwidgetsmall.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Widget otpWidget() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textWidget(text: 'Phone Verification'),
        textWidget(
          text: "Enter Your One Time Password\n(OTP)",
        ),
        const SizedBox(
          height: 40,
        ),
        Container(width: Get.width, height: 50, child: RoundedWithShadow()),
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
                style: GoogleFonts.poppins(color: Colors.black, fontSize: 12),
                children: [
                  TextSpan(
                    text: 'If You Dont Have A code (OTP) ',
                  ),
                  TextSpan(
                      text: "10 seconds",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                ]),
          ),
        )
      ],
    ),
  );
}
