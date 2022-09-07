import 'package:flutter/material.dart';
import 'package:hornoxe_app/services/hornoxe_service.dart';
import 'package:provider/provider.dart';

class PicdumpScreen extends StatelessWidget {
  const PicdumpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hornoxeService = context.watch<HornoxeService>();
    final imageUrls = hornoxeService.imageUrls;

    return Scaffold(
      appBar: AppBar(title: const Text("Picdump #42 🤭")),
      body: SafeArea(
        child: imageUrls == null
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: imageUrls.length,
                itemBuilder: (context, index) {
                  bool isLastImage = index == imageUrls.length - 1;

                  return Padding(
                    padding:
                        EdgeInsets.fromLTRB(20, 20, 20, isLastqImage ? 20 : 0),
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
