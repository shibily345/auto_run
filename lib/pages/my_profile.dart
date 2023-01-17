import 'dart:io';

import 'package:auto_run/controller/auth_controller.dart';
import 'package:auto_run/core/const.dart';
import 'package:auto_run/widgets/green_intro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController homeController = TextEditingController();
  TextEditingController businessController = TextEditingController();
  TextEditingController shopController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AuthController authController = Get.find<AuthController>();

  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      selectedImage = File(image.path);
      setState(() {});
    }
  }

  late LatLng homeAddress;
  late LatLng businessAddress;
  late LatLng shoppingAddress;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = authController.myUser.value.name ?? "";
    homeController.text = authController.myUser.value.hAddress ?? "";
    shopController.text = authController.myUser.value.mallAddress ?? "";
    businessController.text = authController.myUser.value.bAddress ?? "";

    homeAddress = authController.myUser.value.homeAddress!;
    businessAddress = authController.myUser.value.bussinessAddres!;
    shoppingAddress = authController.myUser.value.shoppingAddress!;
  }

  @override
  Widget build(BuildContext context) {
    print(authController.myUser.value.image!);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Get.height * 0.36,
              child: Stack(
                children: [
                  greenIntroWidgetWithoutLogos(title: 'My Profile'),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        getImage(ImageSource.camera);
                      },
                      child: selectedImage == null
                          ? authController.myUser.value.image != null
                              ? Container(
                                  width: 120,
                                  height: 120,
                                  margin: EdgeInsets.only(bottom: 20),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(authController
                                              .myUser.value.image!),
                                          fit: BoxFit.cover),
                                      shape: BoxShape.circle,
                                      color: Color(0xffD6D6D6)),
                                )
                              : Container(
                                  width: 120,
                                  height: 120,
                                  margin: EdgeInsets.only(bottom: 20),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffD6D6D6)),
                                  child: Center(
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                          : Container(
                              width: 120,
                              height: 120,
                              margin: EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: FileImage(selectedImage!),
                                      fit: BoxFit.cover),
                                  shape: BoxShape.circle,
                                  color: Color(0xffD6D6D6)),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 23),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFieldWidget(
                      'Name',
                      Icons.person_outlined,
                      nameController,
                      (String? input) {
                        if (input!.isEmpty) {
                          return 'Name is required!';
                        }

                        if (input.length < 5) {
                          return 'Please enter a valid name!';
                        }

                        return null;
                      },
                    ),
                    bigspace,
                    TextFieldWidget(
                        'Home Address', Icons.home_outlined, homeController,
                        (String? input) {
                      if (input!.isEmpty) {
                        return 'Home Address is required!';
                      }

                      return null;
                    }, onTap: () async {
                      Prediction? p =
                          await authController.showGoogleAutoComplete(context);

                      /// now let's translate this selected address and convert it to latlng obj

                      homeAddress = await authController
                          .buildLatLngFromAddress(p!.description!);
                      homeController.text = p.description!;

                      // /store this information into firebase together once update is clicked
                    }, readOnly: true),
                    bigspace,
                    TextFieldWidget(
                        'Occupation ', Icons.card_travel, businessController,
                        (String? input) {
                      if (input!.isEmpty) {
                        return 'Business Address is required!';
                      }

                      return null;
                    }, onTap: () async {
                      Prediction? p =
                          await authController.showGoogleAutoComplete(context);

                      /// now let's translate this selected address and convert it to latlng obj

                      businessAddress = await authController
                          .buildLatLngFromAddress(p!.description!);
                      businessController.text = p.description!;

                      ///store this information into firebase together once update is clicked
                    }, readOnly: true),
                    bigspace,
                    TextFieldWidget(
                        'District', Icons.location_on_outlined, shopController,
                        (String? input) {
                      if (input!.isEmpty) {
                        return 'Shopping Center is required!';
                      }

                      return null;
                    }, onTap: () async {
                      Prediction? p =
                          await authController.showGoogleAutoComplete(context);

                      /// now let's translate this selected address and convert it to latlng obj

                      shoppingAddress = await authController
                          .buildLatLngFromAddress(p!.description!);
                      shopController.text = p.description!;

                      ///store this information into firebase together once update is clicked
                    }, readOnly: true),
                    bigspace,
                    bigspace,
                    Obx(() => authController.isProfileUploading.value
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : greenButton('Update', () {
                            if (!formKey.currentState!.validate()) {
                              return;
                            }

                            authController.isProfileUploading(true);
                            authController.storeUserInfo(
                              selectedImage,
                              nameController.text,
                              homeController.text,
                              businessController.text,
                              shopController.text,
                              url: authController.myUser.value.image ?? "",
                              homeLatLng: homeAddress,
                              shoppingLatLng: shoppingAddress,
                              businessLatLng: businessAddress,
                            );
                          })),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  TextFieldWidget(String title, IconData iconData,
      TextEditingController controller, Function validator,
      {Function? onTap, bool readOnly = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 113, 113, 113)),
        ),
        const SizedBox(
          height: 6,
        ),
        Container(
          width: Get.width,
          height: 50,
          decoration: BoxDecoration(
              color: Color.fromARGB(132, 236, 233, 229),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 1)
              ],
              borderRadius: BorderRadius.circular(8)),
          child: TextFormField(
            readOnly: readOnly,
            onTap: () => onTap!(),
            validator: (input) => validator(input),
            controller: controller,
            style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 173, 171, 171)),
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(
                  iconData,
                  color: Color.fromARGB(255, 238, 179, 0),
                ),
              ),
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }

  Widget greenButton(String title, Function onPressed) {
    return MaterialButton(
      minWidth: Get.width,
      height: 50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      color: yellow,
      onPressed: () => onPressed(),
      child: Text(
        title,
        style: GoogleFonts.poppins(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
