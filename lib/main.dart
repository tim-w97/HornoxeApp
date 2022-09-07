import 'package:flutter/material.dart';
import 'package:hornoxe_app/screens/picdump_screen.dart';
import 'package:hornoxe_app/services/hornoxe_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const HornoxeApp());
}

class HornoxeApp extends StatelessWidget {
  const HornoxeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => ChangeNotifierProvider(
              create: (context) => HornoxeService(),
              child: const PicdumpScreen(),
            ),
      },
    );
  }
}
