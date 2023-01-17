import 'dart:io';

import 'package:auto_run/controller/auth_controller.dart';
import 'package:auto_run/core/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/green_intro.dart';

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController homeController = TextEditingController();
  TextEditingController businessController = TextEditingController();
  TextEditingController shopController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AuthController authController = Get.find<AuthController>();
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  late LatLng homeAddress;
  late LatLng businessAddress;
  late LatLng shoppingAddress;
  getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      selectedImage = File(image.path);
      setState(() {});
    }
  }

  bool isloading = false;
  @override
  Widget build(BuildContext context) {
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
                  greenIntroWidgetWithoutLogos(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        getImage(ImageSource.camera);
                      },
                      child: selectedImage == null
                          ? Container(
                              width: 120,
                              height: 120,
                              margin: const EdgeInsets.only(bottom: 20),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffD6D6D6)),
                              child: const Center(
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
            bigspace,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 23),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFieldWidget(
                        "Name", EvaIcons.personOutline, nameController,
                        (String? input) {
                      if (input!.isEmpty) {
                        return 'Name is required!';
                      }

                      if (input.length < 5) {
                        return 'Please enter a valid name!';
                      }

                      return null;
                    }),
                    bigspace,
                    TextFieldWidget(
                        "Home Adress", EvaIcons.homeOutline, homeController,
                        (String? input) {
                      if (input!.isEmpty) {
                        return 'Name is required!';
                      }

                      if (input.length < 5) {
                        return 'Please enter a valid name!';
                      }

                      return null;
                    }),
                    bigspace,
                    TextFieldWidget(
                        "Occupation", EvaIcons.bookOutline, businessController,
                        (String? input) {
                      if (input!.isEmpty) {
                        return 'Name is required!';
                      }

                      if (input.length < 5) {
                        return 'Please enter a valid name!';
                      }

                      return null;
                    }),
                    bigspace,
                    TextFieldWidget(
                        "District", Icons.location_on_outlined, shopController,
                        (String? input) {
                      if (input!.isEmpty) {
                        return 'Name is required!';
                      }

                      if (input.length < 5) {
                        return 'Please enter a valid name!';
                      }

                      return null;
                    }),
                    bigspace,
                    litlespace,
                    Obx(() => authController.isProfileUploading.value
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : greenButton('Submit', () {
                            if (!formKey.currentState!.validate()) {
                              return;
                            }

                            if (selectedImage == null) {
                              Get.snackbar('Warning', 'Please add your image');
                              return;
                            }
                            authController.isProfileUploading(true);
                            authController.storeUserInfo(
                                selectedImage!,
                                nameController.text,
                                homeController.text,
                                businessController.text,
                                shopController.text,
                                businessLatLng: businessAddress,
                                homeLatLng: homeAddress,
                                shoppingLatLng: shoppingAddress);
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
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: bc,
        letterSpacing: 2,
      ),
    ),
  );
}
