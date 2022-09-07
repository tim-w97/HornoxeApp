import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:html/parser.dart';

class HornoxeService with ChangeNotifier {
  List<String>? imageUrls;

  HornoxeService() {
    _fetchImages();
  }

  void _fetchImages() async {
    Uri hornoxeUri =
        Uri.parse("https://www.hornoxe.com/hornoxe-com-picdump-793/");

    final response = await get(hornoxeUri, headers: {"charset": "utf-8"});

    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      final html = utf8.decode(bytes, allowMalformed: true);
      final document = parse(html, encoding: "utf-8");

      imageUrls = document
          .querySelectorAll("#ngg-gallery-1442-44481 img")
          .map((element) => element.attributes["src"]!)
          .toList();

      notifyListeners();
    }
  }
}
