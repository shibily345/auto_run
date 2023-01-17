import 'dart:ui' as ui;
import 'dart:ui';
import 'package:auto_run/widgets/destination_sheet.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:auto_run/controller/auth_controller.dart';
import 'package:auto_run/controller/polyline_handler.dart';
import 'package:auto_run/core/const.dart';
import 'package:auto_run/model/userModel.dart';
import 'package:auto_run/pages/payment.dart';
import 'package:auto_run/pages/profile_setting.dart';
import 'package:blur_container/blur_container.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:google_maps_webservice/places.dart';
import 'package:geocoding/geocoding.dart' as geoCoding;
import 'package:location/location.dart' as locationo;
import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../widgets/slide_up.dart';
import '../widgets/text_widget.dart';
import 'my_profile.dart';

class homeScreen extends StatefulWidget {
  homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  String? _mapStyle;
  AuthController authController = Get.find<AuthController>();
  final panalController = PanelController();
  var myUser = UserModel().obs;
  late LatLng destination;
  late LatLng myLocation;
  late LatLng source;
  final Set<Polyline> _polyline = {};
  Set<Marker> markers = Set<Marker>();
  List<String> list = <String>[
    '**** **** **** 8789',
    '**** **** **** 8921',
    '**** **** **** 1233',
    '**** **** **** 4352'
  ];

  @override
  void initState() {
    super.initState();

    authController.getUserInfo();

    rootBundle.loadString('assets/map_style.txt').then((String) {
      _mapStyle = String;
    });
    getCurrentLocation();
    loadCustomMarker();
  }

  String dropdownValue = '**** **** **** 8789';

  GoogleMapController? myMapController;

  LocationData? currentLocation;

  void getCurrentLocation() {
    locationo.Location location = locationo.Location();
    location.getLocation().then((location) {
      currentLocation = location;
    });
  }

  // final PanelController panelController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      // ),
      drawer: buildDrawer(),
      body: SlidingUpPanel(
        color: NeumorphicColors.darkBackground,
        controller: panalController,
        minHeight: Get.height * 0.45,
        panelBuilder: (controller) => panelWidget(
          controller: controller,
          panalController: panalController,
        ),
        parallaxEnabled: true,
        parallaxOffset: .5,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: GoogleMap(
                markers: markers,
                polylines: polyline,
                zoomControlsEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  myMapController = controller;

                  myMapController!.setMapStyle(_mapStyle);
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(10.1632, 76.6413),
                  zoom: 8,
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 50.0, left: 20),
            //   child: profpic(authController: authController),
            // ),
            drawerBar(authController: authController),

            // buildNotificationIcon(),
            buildBottomSheet(),
          ],
        ),
      ),
    );
  }

  Widget panelWidget(
      {required ScrollController controller,
      required PanelController panalController}) {
    return ListView(
      controller: controller,
      padding: EdgeInsets.zero,
      children: <Widget>[
        litlespace,
        buildDragHandle(),
        bigspace,
        buildProfileTile(),
        buildTextField(),
        bigspace,
        Row(
          children: [
            showSourceField
                ? buildTextFieldFrom()
                : Container(
                    padding: EdgeInsets.only(left: 26),
                    width: Get.width * 0.75,
                    height: 106,
                    child: buildDriversList(),
                  ),
            Spacer(),
            buildCurrentLocationIcon(),
          ],
        ),
        bigspace,
      ],
    );
  }

  Widget buildDragHandle() {
    return InkWell(
      child: Center(
        child: Container(
          width: 50,
          height: 5,
          decoration: BoxDecoration(
            color: ui.Color.fromARGB(255, 215, 214, 214),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  void togglePanel() {
    return;
  }

  Widget buildProfileTile() {
    return Obx(
      () => authController.myUser.value.name == null
          ? InkWell(
              onTap: () {
                Get.to(ProfileSettingScreen());
              },
              child: Container(
                alignment: Alignment.topCenter,
                height: 50,
                width: 370,
                decoration: BoxDecoration(
                    color: ui.Color.fromARGB(255, 161, 159, 159),
                    borderRadius: BorderRadius.circular(15)),
                child: Text(
                  'Add Profile',
                  style: TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w800, color: bc),
                ),
              ),
            )
          : Container(
              width: Get.width,
              height: 70,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(color: NeumorphicColors.darkBackground),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'Good Morning, ',
                              style: TextStyle(
                                  color: ui.Color.fromARGB(255, 161, 160, 160),
                                  fontSize: 14)),
                          TextSpan(
                              text: authController.myUser.value.name,
                              style: TextStyle(
                                  color: yellow,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ]),
                      ),
                      Text(
                        "Where are you going?",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: ui.Color.fromARGB(255, 160, 158, 158)),
                      )
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  TextEditingController destinationController = TextEditingController();
  TextEditingController sourceController = TextEditingController();

  bool showSourceField = false;

  Widget buildTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Container(
        width: Get.width,
        height: 50,
        padding: EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
            color: ui.Color.fromARGB(255, 205, 201, 201),
            boxShadow: [
              BoxShadow(
                  color:
                      ui.Color.fromARGB(255, 123, 123, 123).withOpacity(0.05),
                  spreadRadius: 4,
                  blurRadius: 10)
            ],
            borderRadius: BorderRadius.circular(8)),
        child: TextFormField(
          controller: destinationController,
          readOnly: true,
          onTap: () async {
            buildDestinationSheet();
          },
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            hintText: 'Search for a destination',
            hintStyle: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            suffixIcon: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(
                EvaIcons.search,
              ),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  late Uint8List markIcons;

  loadCustomMarker() async {
    markIcons = await loadAsset('assets/point.png', 100);
  }

  Future<Uint8List> loadAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Widget buildTextFieldFrom() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 26,
      ),
      child: Container(
        width: Get.width * 0.6,
        height: 50,
        padding: EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 4,
                  blurRadius: 10)
            ],
            borderRadius: BorderRadius.circular(8)),
        child: TextFormField(
          controller: sourceController,
          readOnly: true,
          onTap: () async {
            buildSourceSheet();
          },
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            hintText: 'From',
            hintStyle: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                EvaIcons.search,
              ),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget buildCurrentLocationIcon() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.only(right: 26),
        child: NeumorphicFloatingActionButton(
          style: nmStyle(),
          onPressed: () {
            myMapController!.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(currentLocation!.latitude!,
                        currentLocation!.longitude!),
                    zoom: 14)));
          },
          child: Icon(
            Icons.my_location_outlined,
            color: yellow,
          ),
        ),
      ),
    );
  }

  NeumorphicStyle nmStyle() {
    return NeumorphicStyle(
      shadowDarkColor: bc,
      shadowLightColor: Colors.grey,
      color: NeumorphicColors.darkBackground,
      shape: NeumorphicShape.convex,
      boxShape: NeumorphicBoxShape.circle(),
    );
  }

  Widget buildNotificationIcon() {
    return const Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: EdgeInsets.only(bottom: 35, left: 8),
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Color.fromARGB(255, 194, 142, 0),
          child: Icon(
            EvaIcons.bellOutline,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
    );
  }

  Widget buildBottomSheet() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: InkWell(
        onTap: () {},
        child: Container(
          width: Get.width * 0.8,
          height: 25,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 4,
                    blurRadius: 10)
              ],
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12), topLeft: Radius.circular(12))),
          child: Center(
            child: Container(
              width: Get.width * 0.6,
              height: 4,
              color: Colors.black45,
            ),
          ),
        ),
      ),
    );
  }

  Future<Prediction?> showGoogleAutoComplete(BuildContext context) async {
    Prediction? p = await PlacesAutocomplete.show(
      offset: 0,
      radius: 1000,
      strictbounds: false,
      region: "pk",
      language: "en",
      context: context,
      mode: Mode.overlay,
      apiKey: "AIzaSyBEh1TK5IbinaixvHUcB4_b1AHKwWrkuic",
      components: [new Component(Component.country, "in")],
      types: [],
      hint: "Search City",
      decoration: InputDecoration(
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );

    return p;
  }

  void drawPolyline(String placeId) {
    _polyline.clear();
    _polyline.add(Polyline(
      polylineId: PolylineId(placeId),
      visible: true,
      points: [source, destination],
      color: bc,
      width: 5,
    ));
  }

  void buildSourceSheet() {
    Get.bottomSheet(Container(
      width: Get.width,
      height: Get.height * 0.5,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          color: Color.fromARGB(255, 208, 199, 176)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Select Your Location",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Home Address",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () async {
              Get.back();
              source = authController.myUser.value.homeAddress!;
              sourceController.text = authController.myUser.value.hAddress!;

              if (markers.length >= 2) {
                markers.remove(markers.last);
              }
              markers.add(Marker(
                  markerId: MarkerId(authController.myUser.value.hAddress!),
                  infoWindow: InfoWindow(
                    title: 'Source: ${authController.myUser.value.hAddress!}',
                  ),
                  position: source));

              await getPolylines(source, destination);

              // drawPolyline(place);

              myMapController!.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(target: source, zoom: 14)));
              setState(() {});
              buildRideConfirmationSheet();
            },
            child: Container(
              width: Get.width,
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        spreadRadius: 4,
                        blurRadius: 10)
                  ]),
              child: Row(
                children: [
                  Text(
                    authController.myUser.value.hAddress!,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Business Address",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () async {
              Get.back();
              source = authController.myUser.value.bussinessAddres!;
              sourceController.text = authController.myUser.value.bAddress!;

              if (markers.length >= 2) {
                markers.remove(markers.last);
              }
              markers.add(Marker(
                  markerId: MarkerId(authController.myUser.value.bAddress!),
                  infoWindow: InfoWindow(
                    title: 'Source: ${authController.myUser.value.bAddress!}',
                  ),
                  position: source));

              await getPolylines(source, destination);

              // drawPolyline(place);

              myMapController!.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(target: source, zoom: 14)));
              setState(() {});

              // buildRideConfirmationSheet();
            },
            child: Container(
              width: Get.width,
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        spreadRadius: 4,
                        blurRadius: 10)
                  ]),
              child: Row(
                children: [
                  Text(
                    authController.myUser.value.bAddress!,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          bigspace,
          InkWell(
            onTap: () async {
              Get.back();
              Prediction? p =
                  await authController.showGoogleAutoComplete(context);

              String place = p!.description!;

              sourceController.text = place;

              source = await authController.buildLatLngFromAddress(place);

              if (markers.length >= 2) {
                markers.remove(markers.last);
              }
              markers.add(Marker(
                  markerId: MarkerId(place),
                  infoWindow: InfoWindow(
                    title: 'Source: $place',
                  ),
                  position: source));

              await getPolylines(source, destination);

              // drawPolyline(place);

              myMapController!.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(target: source, zoom: 14)));
              setState(() {});
              buildRideConfirmationSheet();
            },
            child: Container(
              width: Get.width,
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        spreadRadius: 4,
                        blurRadius: 10)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Search for Address",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
          bigspace,
          InkWell(
            onTap: () async {
              Get.back();

              String selectedPlace = LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!)
                  .toString();
              sourceController.text = selectedPlace;
              myLocation = LatLng(
                  currentLocation!.latitude!, currentLocation!.longitude!);

              if (markers.length >= 2) {
                markers.remove(markers.last);
              }
              markers.add(Marker(
                  markerId: MarkerId(selectedPlace),
                  infoWindow: InfoWindow(
                    title: 'Source: $selectedPlace',
                  ),
                  position: myLocation));
              await getPolylines(myLocation, destination);

              myMapController!.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(target: myLocation, zoom: 14)
                  //17 is new zoom level
                  ));
              setState(() {});
              buildRideConfirmationSheet();
            },
            child: Container(
              width: Get.width,
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        spreadRadius: 4,
                        blurRadius: 10)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Current Location",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  void buildDestinationSheet() {
    Get.bottomSheet(Container(
      width: Get.width,
      height: Get.height * 0.5,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          color: Color.fromARGB(255, 208, 199, 176)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Select Your Location",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Home Address",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () async {
              Get.back();
              destination = authController.myUser.value.homeAddress!;
              destinationController.text =
                  authController.myUser.value.hAddress!;

              if (markers.length >= 2) {
                markers.remove(markers.last);
              }
              markers.add(Marker(
                  markerId: MarkerId(authController.myUser.value.hAddress!),
                  infoWindow: InfoWindow(
                    title:
                        'destination: ${authController.myUser.value.hAddress!}',
                  ),
                  position: destination));

              // await getPolylines(source, destination);

              // drawPolyline(place);

              myMapController!.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(target: destination, zoom: 14)));
              setState(() {});

              // buildRideConfirmationSheet();
            },
            child: Container(
              width: Get.width,
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        spreadRadius: 4,
                        blurRadius: 10)
                  ]),
              child: Row(
                children: [
                  Text(
                    authController.myUser.value.hAddress!,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Business Address",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () async {
              Get.back();
              destination = authController.myUser.value.bussinessAddres!;
              destinationController.text =
                  authController.myUser.value.bAddress!;

              if (markers.length >= 2) {
                markers.remove(markers.last);
              }
              markers.add(Marker(
                  markerId: MarkerId(authController.myUser.value.bAddress!),
                  infoWindow: InfoWindow(
                    title:
                        'destination: ${authController.myUser.value.bAddress!}',
                  ),
                  position: destination));

              // await getPolylines(source, destination);

              // drawPolyline(place);

              myMapController!.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(target: destination, zoom: 14)));
              setState(() {});

              // buildRideConfirmationSheet();
            },
            child: Container(
              width: Get.width,
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        spreadRadius: 4,
                        blurRadius: 10)
                  ]),
              child: Row(
                children: [
                  Text(
                    authController.myUser.value.bAddress!,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () async {
              Get.back();
              Prediction? p = await showGoogleAutoComplete(context);

              String selectedPlace = p!.description!;
              destinationController.text = selectedPlace;
              List<geoCoding.Location> locations =
                  await geoCoding.locationFromAddress(selectedPlace);

              destination =
                  LatLng(locations.first.latitude, locations.first.longitude);

              markers.add(Marker(
                markerId: MarkerId(selectedPlace),
                infoWindow: InfoWindow(
                  title: 'Destination: $selectedPlace',
                ),
                position: destination,
                icon: BitmapDescriptor.fromBytes(markIcons),
              ));

              myMapController!.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(target: destination, zoom: 14)
                  //17 is new zoom level
                  ));
              setState(() {
                showSourceField = true;
              });
            },
            child: Container(
              width: Get.width,
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        spreadRadius: 4,
                        blurRadius: 10)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Search for Address",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  buildRideConfirmationSheet() {
    Get.bottomSheet(Container(
      width: Get.width,
      height: Get.height * 0.4,
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(12), topLeft: Radius.circular(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              width: Get.width * 0.2,
              height: 8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.grey),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          textWidget(
              text: 'Select an option:',
              fontSize: 18,
              fontWeight: FontWeight.bold),
          const SizedBox(
            height: 20,
          ),
          buildDriversList(),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Divider(),
          ),
          bigspace,
          bigspace,
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: buildPaymentCardWidget()),
                MaterialButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: textWidget(
                    text: 'Confirm',
                    color: Colors.white,
                  ),
                  color: yellow,
                  shape: StadiumBorder(),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }

  buildPaymentCardWidget() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/visa.png',
            width: 40,
          ),
          SizedBox(
            width: 10,
          ),
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.keyboard_arrow_down),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: textWidget(text: value),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}

int selectedRide = 0;

buildDriversList() {
  return Container(
    height: 90,
    width: Get.width,
    child: StatefulBuilder(builder: (context, set) {
      return ListView.builder(
        itemBuilder: (ctx, i) {
          return InkWell(
            onTap: () {
              set(() {
                selectedRide = i;
              });
            },
            child: buildDriverCard(selectedRide == i),
          );
        },
        itemCount: 3,
        scrollDirection: Axis.horizontal,
      );
    }),
  );
}

buildDriverCard(bool selected) {
  return Container(
    margin: EdgeInsets.only(right: 8, left: 8, top: 4, bottom: 4),
    height: 105,
    width: 135,
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: selected
                  ? Color.fromARGB(255, 255, 196, 0).withOpacity(0.2)
                  : Colors.grey.withOpacity(0.2),
              offset: Offset(0, 5),
              blurRadius: 5,
              spreadRadius: 1)
        ],
        borderRadius: BorderRadius.circular(12),
        color: selected ? Color.fromARGB(255, 253, 208, 4) : Colors.grey),
    child: Stack(
      children: [
        Container(
          padding: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textWidget(
                  text: 'Standard',
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
              textWidget(
                  text: '₹ 9.90',
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
              textWidget(
                  text: '3 MIN',
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.normal,
                  fontSize: 12),
            ],
          ),
        ),
        Positioned(
            right: -15,
            top: 0,
            bottom: 0,
            child: Image.asset('assets/ggCard1.png'))
      ],
    ),
  );
}

buildDrawerItem(
    {required String title,
    required Function onPressed,
    Color color = Colors.grey,
    double fontSize = 20,
    FontWeight fontWeight = FontWeight.w700,
    double height = 45,
    bool isVisible = false}) {
  return SizedBox(
    height: height,
    child: ListTile(
      contentPadding: EdgeInsets.all(0),
      // minVerticalPadding: 0,
      dense: true,
      onTap: () => onPressed(),
      title: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
                fontSize: fontSize, fontWeight: fontWeight, color: Colors.grey),
          ),
          const SizedBox(
            width: 5,
          ),
          isVisible
              ? CircleAvatar(
                  backgroundColor: yellow,
                  radius: 10,
                  child: Text(
                    '1',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                  ),
                )
              : Container()
        ],
      ),
    ),
  );
}

AuthController authController = Get.find<AuthController>();
buildDrawer() {
  return Drawer(
    backgroundColor: NeumorphicColors.darkBackground,
    child: Column(
      children: [
        InkWell(
          onTap: () {
            Get.to(() => const MyProfile());
          },
          child: SizedBox(
            height: 150,
            child: DrawerHeader(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: yellow,
                      image: authController.myUser.value.image == null
                          ? const DecorationImage(
                              image: AssetImage('assets/person.png'),
                              fit: BoxFit.cover)
                          : DecorationImage(
                              image: NetworkImage(
                                  authController.myUser.value.image!),
                              fit: BoxFit.cover)),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Good Morning, ',
                          style: GoogleFonts.poppins(
                              color: ui.Color.fromARGB(255, 239, 233, 233)
                                  .withOpacity(0.28),
                              fontSize: 14)),
                      Text(
                        // 'Shibulyee ',
                        authController.myUser.value.name == null
                            ? "Mark"
                            : authController.myUser.value.name!,
                        style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: yellow),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )
                    ],
                  ),
                )
              ],
            )),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              buildDrawerItem(
                  title: 'Payment History',
                  onPressed: () {
                    Get.to(PaymentScreen());
                  }),
              buildDrawerItem(
                  title: 'Ride History', onPressed: () {}, isVisible: true),
              buildDrawerItem(title: 'Save a Location', onPressed: () {}),
              buildDrawerItem(title: 'Promo Codes', onPressed: () {}),
              buildDrawerItem(title: 'Settings', onPressed: () {}),
              buildDrawerItem(title: 'Support', onPressed: () {}),
              buildDrawerItem(
                  title: 'Log Out',
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  }),
            ],
          ),
        ),
        Spacer(),
        Divider(
          color: Colors.grey,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            children: [
              buildDrawerItem(
                  title: 'Do more',
                  onPressed: () {},
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.15),
                  height: 20),
              const SizedBox(
                height: 20,
              ),
              buildDrawerItem(
                  title: 'Get food delivery',
                  onPressed: () {},
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.15),
                  height: 20),
              buildDrawerItem(
                  title: 'Make money driving',
                  onPressed: () {},
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.15),
                  height: 20),
              buildDrawerItem(
                title: 'Rate us on store',
                onPressed: () {},
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.15),
                height: 20,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    ),
  );
}
