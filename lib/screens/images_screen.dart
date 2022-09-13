import 'package:flutter/material.dart';
import 'package:hornoxe_app/providers/picdump_provider.dart';
import 'package:hornoxe_app/widgets/horni_rolling_eyes.dart';
import 'package:provider/provider.dart';

class ImagesScreen extends StatelessWidget {
  const ImagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final picdumpProvider = context.watch<PicdumpProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Picdump ${picdumpProvider.currentPicdump.hash}"),
      ),
      body: SafeArea(
        child: StreamBuilder<List<String>>(
            stream: picdumpProvider.imageLinks,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const HorniRollingEyes();
              }

              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.network(
                      snapshot.data!.elementAt(index),
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
