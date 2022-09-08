import 'package:flutter/material.dart';
import 'package:hornoxe_app/services/crawler.dart';

class PicdumpProvider with ChangeNotifier {
  final crawler = Crawler();

  List<String>? imageLinks;

  PicdumpProvider() {
    _fetchImageLinks();
  }

  void _fetchImageLinks() async {
    imageLinks = await crawler.imageLinks;
    notifyListeners();
  }
}
