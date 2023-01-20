import 'package:auto_run/core/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:location/location.dart' as locationo;
import '../../controller/auth_controller.dart';
import '../../model/userModel.dart';
import '../../pages/home_screen..dart';
import '../../widgets/slide_up.dart';

class DriverHome extends StatefulWidget {
  const DriverHome({super.key});

  @override
  State<DriverHome> createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {
  AuthController authController = Get.find<AuthController>();
  final panalController = PanelController();
  var myUser = driverModel().obs;
  String? _mapStyleLight;
  GoogleMapController? myMapController;
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    authController.getUserInfo();

    // rootBundle.loadString('assets/map_style.txt').then((String) {
    //   _mapStyle = String;
    // });
    rootBundle.loadString('assets/map_style_light.txt').then((String) {
      _mapStyleLight = String;
    });
  }

  LocationData? currentLocation;
  void getCurrentLocation() {
    locationo.Location location = locationo.Location();
    location.getLocation().then((location) {
      currentLocation = location;

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final panelHeigtmin = MediaQuery.of(context).size.height * 0.4;
    final panelHeigtmax = MediaQuery.of(context).size.height * 0.8;
    return Scaffold(
      drawer: buildDrawer(context),
      body: SlidingUpPanel(
        color: Theme.of(context).primaryColor,
        controller: panalController,
        minHeight: panelHeigtmin,
        maxHeight: panelHeigtmax,
        panelBuilder: (controller) => panelWidget(
          controller: controller,
          panalController: panalController,
        ),
        parallaxEnabled: true,
        parallaxOffset: .5,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: currentLocation == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GoogleMap(
                      zoomControlsEnabled: false,
                      onMapCreated: (GoogleMapController controller) {
                        myMapController = controller;
                        setState(() {
                          myMapController!.setMapStyle(_mapStyleLight);
                        });
                      },
                      initialCameraPosition: CameraPosition(
                        target: LatLng(currentLocation!.latitude!,
                            currentLocation!.longitude!),
                        zoom: 15,
                      ),
                    ),
            ),
            drawerBar(authController: authController),
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
          InkWell(
            child: Center(
              child: Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          bigspace,
          buildProfileTile()
        ]);
  }

  Widget buildProfileTile() {
    return Container(
      width: Get.width,
      height: 70,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: 'Hey  ',
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 14)),
                  const TextSpan(
                      text: 'Shibil',
                      style: TextStyle(
                          color: yellow,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ]),
              ),
              Text(
                "Redy To Go ..",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColorDark),
              )
            ],
          ),
        ],
      ),
    );
  }
}
