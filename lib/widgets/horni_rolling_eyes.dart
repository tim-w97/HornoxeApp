import 'package:flutter/material.dart';

class HorniRollingEyes extends StatelessWidget {
  const HorniRollingEyes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "images/horni_rolling_eyes.gif",
        width: 200,
      ),
    );
  }
}
