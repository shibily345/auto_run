import 'package:auto_run/core/const.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget greenIntroWidget() {
  return Container(
    height: Get.height * 0.6,
    width: Get.width,
    decoration: const BoxDecoration(
      image: DecorationImage(
          image: AssetImage('assets/bg2.png'), fit: BoxFit.cover),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 200),
          child: SizedBox(
            height: 80,
            child: SvgPicture.asset(
              'assets/llogo.svg',
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SvgPicture.asset('assets/biglog.svg'),
      ],
    ),
  );
}

Widget greenIntroWidgetWithoutLogos(
    {String title = "SET YOUR\n PROFILE", String? subtitle}) {
  return Container(
    width: Get.width,
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/bg2.png'), fit: BoxFit.fill)),
    height: Get.height * 0.32,
    child: Container(
        height: Get.height * 0.1,
        width: Get.width,
        margin: EdgeInsets.only(bottom: Get.height * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                  letterSpacing: 1,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: bc),
            ),
            if (subtitle != null)
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 0, 0, 0)),
              ),
          ],
        )),
  );
}
