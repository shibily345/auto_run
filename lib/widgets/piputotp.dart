import 'package:auto_run/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class RoundedWithShadow extends StatefulWidget {
  const RoundedWithShadow({Key? key}) : super(key: key);

  @override
  _RoundedWithShadowState createState() => _RoundedWithShadowState();

  @override
  String toStringShort() => 'Rounded With Shadow';
}

class _RoundedWithShadowState extends State<RoundedWithShadow> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  AuthController authcontroller = Get.find<AuthController>();
  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 64,
      textStyle: GoogleFonts.poppins(
          fontSize: 20, color: Color.fromARGB(255, 255, 162, 0)),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 78, 76, 76),
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              blurRadius: 30,
              offset: Offset(10, 10),
              color: Color.fromARGB(41, 0, 0, 0),
            ),
            BoxShadow(
              blurRadius: 20,
              offset: Offset(-10, -10),
              color: Color.fromARGB(41, 246, 241, 241),
            ),
          ]),
    );

    final cursor = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 21,
        height: 1,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(137, 146, 160, 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );

    return Pinput(
      length: 6,
      controller: controller,
      focusNode: focusNode,
      onCompleted: (String input) {
        authcontroller.verifyOtp(input);
      },
      defaultPinTheme: defaultPinTheme,
      separator: const SizedBox(width: 16),
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                blurRadius: 30,
                offset: Offset(10, 10),
                color: Color.fromARGB(41, 0, 0, 0),
              ),
              BoxShadow(
                blurRadius: 20,
                offset: Offset(-10, -10),
                color: Color.fromARGB(41, 246, 241, 241),
              ),
            ]),
      ),
      showCursor: true,
      cursor: cursor,
    );
  }
}
