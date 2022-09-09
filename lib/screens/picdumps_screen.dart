import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hornoxe_app/providers/picdump_provider.dart';
import 'package:provider/provider.dart';

class PicdumpsScreen extends StatelessWidget {
  const PicdumpsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final picdumpProvider = context.watch<PicdumpProvider>();

    final picdumps = picdumpProvider.picdumps;

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Picdumps"),
      ),
      body: SafeArea(
        child: picdumps == null
            ? Center(
                child: SpinKitThreeInOut(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              )
            : ListView.builder(
                itemCount: picdumps.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: MaterialButton(
                      padding: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        picdumpProvider.setImages(
                          ofPicdump: picdumps.elementAt(index),
                        );

                        Navigator.pushNamed(
                          context,
                          "/images",
                        );
                      },
                      child: Text(
                        picdumps.elementAt(index).hash,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
