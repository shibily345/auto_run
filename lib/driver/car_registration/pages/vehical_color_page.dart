import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VehicalColorPage extends StatefulWidget {
  const VehicalColorPage({Key? key, required this.onColorSelected})
      : super(key: key);

  final Function onColorSelected;

  @override
  State<VehicalColorPage> createState() => _VehicalColorPageState();
}

class _VehicalColorPageState extends State<VehicalColorPage> {
  String dropdownvalue = 'Pick a color';

  List<String> colors = [
    'Pick a color',
    'Yellow/Black',
    "Yellow",
    "Black",
    'Green/Yellow',
    "White/Blue",
    "Other",
  ];

  buildDropDown() {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
      child: DropdownButton(
        // Initial Value
        value: dropdownvalue,

        isExpanded: true,
        underline: Container(
          color: Theme.of(context).primaryColor,
        ),

        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: colors.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(
              items,
              style: TextStyle(color: Theme.of(context).primaryColorDark),
            ),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (String? newValue) {
          setState(() {
            dropdownvalue = newValue!;
          });
          widget.onColorSelected(newValue!);
        },
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
          'Which color of vehicle is it ?',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColorDark),
        ),
        const SizedBox(
          height: 30,
        ),
        buildDropDown(),
      ],
    );
  }
}
