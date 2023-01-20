import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class VehicalNumberPage extends StatefulWidget {
  const VehicalNumberPage({Key? key, required this.controller})
      : super(key: key);

  final TextEditingController controller;

  @override
  State<VehicalNumberPage> createState() => _VehicalNumberPageState();
}

class _VehicalNumberPageState extends State<VehicalNumberPage> {
  TextFieldWidget(
      String title, TextEditingController controller, Function validator,
      {Function? onTap, bool readOnly = false}) {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      // height: 50,
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
      child: TextFormField(
        readOnly: readOnly,
        onTap: () => onTap!(),
        validator: (input) => validator(input),
        controller: controller,
        style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColorDark),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          hintStyle: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).primaryColorDark),
          hintText: title,
          border: InputBorder.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Vehicle Number ?',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColorDark),
        ),
        const SizedBox(
          height: 30,
        ),
        TextFieldWidget(
            'Enter Vehical Number', widget.controller, (String v) {},
            readOnly: false),
      ],
    );
  }
}
