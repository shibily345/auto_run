import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart' as lottie;

class PanelWidget1 extends StatelessWidget {
  final ScrollController controller;
  const PanelWidget1({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return const distenceShow();
  }
}

class distenceShow extends StatelessWidget {
  const distenceShow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Center(
          child: lottie.Lottie.asset('assets/63680-on-the-way.json'),
        ),
      ],
    );
  }
}
