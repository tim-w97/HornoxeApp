import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hornoxe_app/providers/picdump_provider.dart';
import 'package:provider/provider.dart';

class PicdumpScreen extends StatelessWidget {
  const PicdumpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final picdump = context.watch<PicdumpProvider>();
    final imageUrls = picdump.imageLinks;

    return Scaffold(
      appBar: AppBar(title: const Text("Picdump #42 🤭")),
      body: SafeArea(
        child: imageUrls == null
            ? Center(
                child: SpinKitThreeInOut(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              )
            : ListView.builder(
                itemCount: imageUrls.length,
                itemBuilder: (context, index) {
                  bool isLastImage = index == imageUrls.length - 1;

                  return Padding(
                    padding:
                        EdgeInsets.fromLTRB(20, 20, 20, isLastImage ? 20 : 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        imageUrls.elementAt(index),
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
