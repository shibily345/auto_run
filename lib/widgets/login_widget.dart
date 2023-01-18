import 'package:auto_run/core/const.dart';
import 'package:auto_run/pages/otp_ver_page.dart';
import 'package:auto_run/pages/profile_setting.dart';
import 'package:auto_run/widgets/textwidgetsmall.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Widget loginWidget(
    CountryCode countryCode, Function onCountrychange, Function onSubmit) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textWidget(text: 'Hello, Nice To Meet You', color1: yellow),
          textWidget(
            text: "Go With Riksaw 'Wherever Whenever'",
            color1: grey,
            fontSize1: 20,
            fontWeight1: FontWeight.bold,
          ),
          bigspace,
          litlespace,
          Container(
            width: double.infinity,
            height: 65,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 127, 127, 127),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 30,
                    offset: Offset(20, 20),
                    color: Color.fromARGB(41, 0, 0, 0),
                  ),
                  BoxShadow(
                    blurRadius: 30,
                    offset: Offset(-20, -20),
                    color: Color.fromARGB(41, 246, 241, 241),
                  ),
                ]),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () => onCountrychange(),
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: countryCode.flagImage,
                                ),
                              ),
                            ),
                            textWidget(text: countryCode.dialCode),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                            ),
                          ],
                        ),
                      )),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      child: Center(
                        child: TextField(
                          onSubmitted: (String? input) => onSubmit(input),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: 'Enter Your Phone Number',
                              hintStyle: GoogleFonts.poppins(),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                  ),
                ),
                // IconButton(
                //   onPressed: () {
                //     Get.to(() => ProfileSettingScreen());
                //   },
                //   icon: Icon(
                //     CupertinoIcons.arrow_right_circle_fill,
                //   ),
                // )
              ],
            ),
          ),
          bigspace,
          litlespace,
          bigspace,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: GoogleFonts.poppins(color: bc, fontSize: 12),
                    children: [
                      TextSpan(
                        style: TextStyle(color: grey),
                        text:
                            'By creating an account, you agree to our Privacy Policy\n',
                      ),
                      TextSpan(
                        text: ' Terms of Service ',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, color: grey),
                      ),
                      TextSpan(
                        text: 'and ',
                        style: TextStyle(color: grey),
                      ),
                      TextSpan(
                          text: 'Privacy Policy',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, color: grey)),
                    ])),
          )
        ],
      ),
    ),
  );
}
