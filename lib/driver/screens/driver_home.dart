import 'package:auto_run/core/const.dart';
import 'package:auto_run/widgets/text_widget.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
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
    final panelHeigtmin = MediaQuery.of(context).size.height * 0.1;
    final panelHeigtmax = MediaQuery.of(context).size.height * 0.8;
    return Scaffold(
      drawer: buildDrawer(context),
      body: Stack(
        children: [
          SlidingUpPanel(
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
            body: Stack(
              alignment: Alignment.topCenter,
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
                Positioned(bottom: 150, child: builFAB(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget panelWidget(
      {required ScrollController controller,
      required PanelController panalController}) {
    return ListView(
        controller: controller,
        padding: EdgeInsets.zero,
        children: <Widget>[litlespace, buildStatus()]);
  }

  Widget buildStatus() {
    return Container(
      width: Get.width,
      height: 60,
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
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(
                  size: 35,
                  color: Theme.of(context).primaryColorDark,
                  Icons.keyboard_arrow_up_rounded,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 74),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textWidget(
                        text: "Offline",
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                    textWidget(text: 'text')
                  ],
                ),
              ),
              SizedBox(
                width: 95,
              ),
              IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(
                  size: 25,
                  color: Theme.of(context).primaryColorDark,
                  EvaIcons.menu2Outline,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget builFAB(BuildContext context) => Transform.scale(
        scale: 1.5,
        child: FloatingActionButton(
          onPressed: () {},
          child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: textWidget(
                    text: "GO", fontSize: 20, fontWeight: FontWeight.bold),
              )),
        ),
      );
}
