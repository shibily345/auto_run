// import 'package:auto_run/core/const.dart';
// import 'package:auto_run/pages/profile_setting.dart';
// import 'package:auto_run/widgets/green_intro.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_credit_card/credit_card_brand.dart';
// import 'package:flutter_credit_card/flutter_credit_card.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_webservice/places.dart';

// import '../controller/auth_controller.dart';
// import 'home_screen..dart';

// class AddLocationsc extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return AddLocationscState();
//   }
// }

// class AddLocationscState extends State<AddLocationsc> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController placeController = TextEditingController();
//   late LatLng locationAddress;

//   String cardHolderName = '';

//   bool isCvvFocused = false;
//   bool useGlassMorphism = false;
//   bool useBackgroundImage = false;
//   OutlineInputBorder? border;
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
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
//         backgroundColor: Colors.white,
//         resizeToAvoidBottomInset: false,
//         body: Column(
//           children: [
//             greenIntroWidgetWithoutLogos(title: 'Add Location'),
//             Column(
//               children: <Widget>[
//                 SizedBox(
//                   height: 150,
//                 ),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: <Widget>[
//                         // TextFieldWidget(
//                         //     "Select A Location",
//                         //     Icons.location_on_outlined,
//                         //     placeController, (String? input) {
//                         //   if (input!.isEmpty) {
//                         //     return 'Shopping Center is required!';
//                         //   }

//                         //   return null;
//                         // }, onTap: () async {
//                         //   Prediction? p = await authController
//                         //       .showGoogleAutoComplete(context);

//                         //   /// now let's translate this selected address and convert it to latlng obj

//                         //   locationAddress = await authController
//                         //       .buildLatLngFromAddress(p!.description!);
//                         //   placeController.text = p.description!;

//                         //   ///store this information into firebase together once update is clicked
//                         // }, readOnly: true),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ));
//   }
// }
