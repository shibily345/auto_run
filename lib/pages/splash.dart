import 'package:auto_run/decision_screen/decission_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Ssplash extends StatefulWidget {
  const Ssplash({super.key});

  @override
  State<Ssplash> createState() => _SsplashState();
}

class _SsplashState extends State<Ssplash> {
  @override
  void initState() {
    gotoLogin();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 200),
              child: SizedBox(
                height: 80,
                child: SvgPicture.asset(
                  'assets/llogo.svg',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SvgPicture.asset('assets/biglog.svg'),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> gotoLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => DecisionScreen(),
    ));
  }
}
