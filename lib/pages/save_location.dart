// import 'package:auto_run/controller/auth_controller.dart';
// import 'package:auto_run/core/const.dart';
// import 'package:auto_run/pages/add_Location.dart';
// import 'package:auto_run/widgets/green_intro.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_credit_card/credit_card_brand.dart';
// import 'package:flutter_credit_card/flutter_credit_card.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'add_payment_card_screen.dart';

// class SaveLocationscreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return SaveLocationscreenState();
//   }
// }

// class SaveLocationscreenState extends State<SaveLocationscreen> {
//   String cardNumber = '5555 55555 5555 4444';
//   String expiryDate = '12/25';
//   String cardHolderName = 'Osama Qureshi';
//   String cvvCode = '123';
//   bool isCvvFocused = false;
//   bool useGlassMorphism = false;
//   bool useBackgroundImage = false;
//   OutlineInputBorder? border;
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   AuthController authController = Get.find<AuthController>();

//   @override
//   void initState() {
//     authController.getUserCards();
//     border = OutlineInputBorder(
//       borderSide: BorderSide(
//         color: Colors.grey.withOpacity(0.7),
//         width: 2.0,
//       ),
//     );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Container(
//         width: Get.width,
//         height: Get.height,
//         child: Stack(
//           children: <Widget>[
//             greenIntroWidgetWithoutLogos(title: 'Saved Locations'),
//             Positioned(
//                 bottom: 10,
//                 right: 10,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text(
//                       "Add new card",
//                       style: GoogleFonts.poppins(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: yellow),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     FloatingActionButton(
//                       onPressed: () {
//                         Get.to(() => AddLocationsc());
//                       },
//                       child: Icon(
//                         Icons.arrow_forward,
//                         color: Colors.white,
//                       ),
//                       backgroundColor: yellow,
//                     )
//                   ],
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
// }
