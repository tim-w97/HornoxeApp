import 'package:flutter/material.dart';
import 'package:hornoxe_app/models/picdump.dart';
import 'package:hornoxe_app/providers/picdump_provider.dart';
import 'package:hornoxe_app/widgets/horni_rolling_eyes.dart';
import 'package:hornoxe_app/widgets/picdump_card.dart';
import 'package:provider/provider.dart';

class PicdumpsScreen extends StatelessWidget {
  const PicdumpsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final picdumpProvider = context.watch<PicdumpProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Picdumps"),
      ),
      body: SafeArea(
        child: StreamBuilder<List<Picdump>>(
          stream: picdumpProvider.picdumps,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const HorniRollingEyes();
            }

            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return PicdumpCard(
                  margin: const EdgeInsets.all(10),
                  picdump: snapshot.data!.elementAt(index),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
