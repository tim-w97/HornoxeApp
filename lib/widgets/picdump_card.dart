import 'package:flutter/material.dart';
import 'package:hornoxe_app/models/picdump.dart';
import 'package:hornoxe_app/providers/picdump_provider.dart';
import 'package:provider/provider.dart';

class PicdumpCard extends StatelessWidget {
  const PicdumpCard({Key? key, required this.picdump, required this.margin})
      : super(key: key);

  final EdgeInsets margin;
  final Picdump picdump;

  @override
  Widget build(BuildContext context) {
    PicdumpProvider picdumpProvider = context.read<PicdumpProvider>();

    return Padding(
      padding: margin,
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
                child: Image.network(
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
  }
}
