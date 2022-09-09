import 'package:flutter/material.dart';
import 'package:hornoxe_app/models/picdump.dart';
import 'package:hornoxe_app/services/crawler.dart';

class PicdumpProvider {
  final crawler = Crawler();

  late Future<List<Picdump>> picdumps;
  late Future<List<String>> imageLinks;

  late Picdump currentPicdump;

  PicdumpProvider() {
    picdumps = crawler.picdumps;
  }

  void setImages({
    required Picdump ofPicdump,
  }) {
    currentPicdump = ofPicdump;
    imageLinks = crawler.fetchImageLinks(fromUri: ofPicdump.uri);
  }
}
