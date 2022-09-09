import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hornoxe_app/providers/picdump_provider.dart';
import 'package:provider/provider.dart';

class ImagesScreen extends StatelessWidget {
  const ImagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final picdumpProvider = context.watch<PicdumpProvider>();

    final imageLinks = picdumpProvider.imageLinks;

    return Scaffold(
      appBar: AppBar(
        title: Text("Picdump ${picdumpProvider.currentPicdump?.hash}"),
      ),
      body: SafeArea(
        child: imageLinks == null
            ? Center(
                child: SpinKitThreeInOut(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              )
            : ListView.builder(
                itemCount: imageLinks.length,
                itemBuilder: (context, index) {
                  bool isLastImage = index == imageLinks.length - 1;

                  return Padding(
                    padding:
                        EdgeInsets.fromLTRB(20, 20, 20, isLastImage ? 20 : 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        imageLinks.elementAt(index),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
