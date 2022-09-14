import 'package:flutter/material.dart';
import 'package:hornoxe_app/providers/picdump_provider.dart';
import 'package:hornoxe_app/widgets/horni_rolling_eyes.dart';
import 'package:hornoxe_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ImagesScreen extends StatelessWidget {
  const ImagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final picdumpProvider = context.watch<PicdumpProvider>();

    Stream<List<Image>> images = picdumpProvider.imageLinks.map(
      (List<String> links) => links
          .map(
            (String link) => Image.network(link, fit: BoxFit.fill),
          )
          .toList(),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Picdump ${picdumpProvider.currentPicdump?.hash}"),
      ),
      body: SafeArea(
        child: StreamBuilder<List<Image>>(
            stream: images,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const HorniRollingEyes();
              }

              if (!snapshot.hasData ||
                  snapshot.hasData && snapshot.data!.isEmpty) {
                return const NoData();
              }

              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: snapshot.data!.elementAt(index),
                  );
                },
              );
            }),
      ),
    );
  }
}
