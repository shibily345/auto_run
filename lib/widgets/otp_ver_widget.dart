import 'package:auto_run/widgets/piputotp.dart';
import 'package:auto_run/widgets/textwidgetsmall.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Widget otpWidget(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textWidget(
            text: 'Phone Verification',
            color1: Theme.of(context).primaryColorDark),
        textWidget(
          text: "Enter Your One Time Password\n(OTP)",
          color1: Theme.of(context).primaryColorDark,
        ),
        const SizedBox(
          height: 40,
        ),
        SizedBox(
            width: Get.width, height: 50, child: const RoundedWithShadow()),
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                    style:
                        GoogleFonts.poppins(color: Colors.black, fontSize: 12),
                    children: [
                      TextSpan(
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark),
                        text: 'If You Dont Have A code (OTP) ',
                      ),
                      TextSpan(
                          text: "10 seconds",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).indicatorColor)),
                    ]),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
