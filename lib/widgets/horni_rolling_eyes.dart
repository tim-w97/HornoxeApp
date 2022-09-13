import 'package:flutter/material.dart';
import 'package:hornoxe_app/providers/picdump_provider.dart';
import 'package:provider/provider.dart';

class HorniRollingEyes extends StatelessWidget {
  const HorniRollingEyes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PicdumpProvider picdumpProvider = context.read<PicdumpProvider>();

    return Center(
      child: Hero(
        tag: picdumpProvider.currentPicdump?.hash ?? "dummy_tag",
        child: Image.asset(
          "images/horni_rolling_eyes.gif",
          width: 200,
        ),
      ),
    );
  }
}
