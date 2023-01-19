import 'package:flutter/material.dart';

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
        ],
      ),
    );
  }
}
