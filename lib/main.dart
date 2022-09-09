import 'package:flutter/material.dart';
import 'package:hornoxe_app/providers/picdump_provider.dart';
import 'package:hornoxe_app/screens/images_screen.dart';
import 'package:hornoxe_app/screens/picdumps_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    Provider(
      create: (context) => PicdumpProvider(),
      child: const HornoxeApp(),
    ),
  );
}

class HornoxeApp extends StatelessWidget {
  const HornoxeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      routes: {
        "/": (context) => const PicdumpsScreen(),
        "/images": (context) => const ImagesScreen(),
      },
    );
  }
}
