import 'package:auto_run/driver/screens/driver_home.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

import '../decision_screen/decission_screen.dart';
import '../widgets/green_intro.dart';

class VerificaitonPendingScreen extends StatefulWidget {
  const VerificaitonPendingScreen({Key? key}) : super(key: key);

  @override
  State<VerificaitonPendingScreen> createState() =>
      _VerificaitonPendingScreenState();
}

class _VerificaitonPendingScreenState extends State<VerificaitonPendingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          greenIntroWidgetWithoutLogos(
              title: 'Verification!', subtitle: 'process status'),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Verification Pending',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColorDark),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Your document is still pending for verification. Once it’s all verified you start getting rides. please sit tight',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).primaryColorDark),
                textAlign: TextAlign.center,
              ),
            ],
          )),
          const SizedBox(
            height: 40,
          ),
          InkWell(
            onTap: () {
              Get.offAll(DecisionScreen());
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Container(
                height: 40,
                width: 100,
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
                child: Center(
                  child: Text(
                    'Log Out',
                    style: TextStyle(color: Theme.of(context).primaryColorDark),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.offAll(const DriverHome());
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Container(
                height: 40,
                width: 100,
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
                child: Center(
                  child: Text(
                    'Log In',
                    style: TextStyle(color: Theme.of(context).primaryColorDark),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
