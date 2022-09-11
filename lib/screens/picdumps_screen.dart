import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hornoxe_app/models/picdump.dart';
import 'package:hornoxe_app/providers/picdump_provider.dart';
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
        child: FutureBuilder<List<Picdump>>(
          future: picdumpProvider.picdumps,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SpinKitThreeInOut(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final picdump = snapshot.data!.elementAt(index);

                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      picdumpProvider.setImages(ofPicdump: picdump);
                      Navigator.pushNamed(context, "/images");
                    },
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Opacity(
                            opacity: 0.5,
                            child: Image.asset(
                              picdump.thumbnailLink,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Center(
                            child: Text(
                              "Picdump ${picdump.hash}",
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 10,
                            bottom: 10,
                            child: Text(
                              picdump.timestamp,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
