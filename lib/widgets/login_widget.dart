import 'package:auto_run/core/const.dart';
import 'package:auto_run/widgets/textwidgetsmall.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget loginWidget(BuildContext context, CountryCode countryCode,
    Function onCountrychange, Function onSubmit) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textWidget(
              text: 'Hello, Nice To Meet You',
              color1: Theme.of(context).indicatorColor),
          textWidget(
            text: "Go With Riksaw 'Wherever Whenever'",
            color1: Theme.of(context).primaryColorDark,
            fontSize1: 20,
            fontWeight1: FontWeight.bold,
          ),
          bigspace,
          litlespace,
          Container(
            width: double.infinity,
            height: 65,
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
                            textWidget(
                                text: countryCode.dialCode,
                                color1: Theme.of(context).primaryColorDark),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Theme.of(context).indicatorColor,
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
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark),
                          onSubmitted: (String? input) => onSubmit(input),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: 'Enter Your Phone Number',
                              hintStyle: GoogleFonts.poppins(
                                  color: Theme.of(context).primaryColorDark),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                  ),
                ),
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
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark),
                        text:
                            'By creating an account, you agree to our Privacy Policy\n',
                      ),
                      TextSpan(
                        text: ' Terms of Service ',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColorDark),
                      ),
                      TextSpan(
                        text: 'and ',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark),
                      ),
                      TextSpan(
                          text: 'Privacy Policy',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColorDark)),
                    ])),
          )
        ],
      ),
    ),
  );
}
