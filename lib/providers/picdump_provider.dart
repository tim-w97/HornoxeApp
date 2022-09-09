import 'package:flutter/material.dart';
import 'package:hornoxe_app/models/picdump.dart';
import 'package:hornoxe_app/services/crawler.dart';

class PicdumpProvider with ChangeNotifier {
  final crawler = Crawler();

  List<Picdump>? picdumps;
  List<String>? imageLinks;

  Picdump? currentPicdump;

  PicdumpProvider() {
    _setPicdumps();
  }

  void _setPicdumps() async {
    picdumps = null;

    picdumps = await crawler.picdumps;
    notifyListeners();
  }

  void setImages({
    required Picdump ofPicdump,
  }) async {
    imageLinks = null;
    currentPicdump = ofPicdump;

    imageLinks = await crawler.fetchImageLinks(fromUri: ofPicdump.uri);

    notifyListeners();
  }
}
