import 'package:flutter/material.dart';
import 'package:hornoxe_app/services/crawler.dart';

class PicdumpProvider with ChangeNotifier {
  final crawler = Crawler();

  Map<String, String>? picdumpLinks;
  List<String>? imageLinks;

  PicdumpProvider() {
    _setPicdumps();
  }

  void _setPicdumps() async {
    picdumpLinks = null;

    picdumpLinks = await crawler.picdumpLinks;
    notifyListeners();
  }

  void setImages({required String fromLink}) async {
    imageLinks = null;

    imageLinks = await crawler.fetchImageLinks(fromUri: Uri.parse(fromLink));
    notifyListeners();
  }
}
