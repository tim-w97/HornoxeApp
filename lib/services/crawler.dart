import 'dart:convert';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';

class Crawler {
  Future<Map<String, String>> get picdumpLinks async {
    final picdumpsUri = Uri.https("hornoxe.com", "picdumps");
    final document = await _getDocument(forUri: picdumpsUri);

    final linkElements = document.querySelectorAll("a[title*='Picdump #']");

    Map<String, String> picdumpLinks = {};

    for (final linkElement in linkElements) {
      String picdumpHash = linkElement.text.split(" ").last;
      String link = linkElement.attributes["href"]!;

      picdumpLinks[picdumpHash] = link;
    }

    return picdumpLinks;
  }

  Future<List<String>> fetchImageLinks({required Uri fromUri}) async {
    final document = await _getDocument(forUri: fromUri);

    final imageUrls = document
        .querySelectorAll("img[title^=picdump]")
        .map((element) => element.attributes["src"]!)
        .toList();

    return imageUrls;
  }

  Future<Document> _getDocument({required Uri forUri}) async {
    final response = await get(forUri);

    final bytes = response.bodyBytes;
    final html = utf8.decode(bytes, allowMalformed: true);
    final document = parse(html, encoding: "utf-8");

    return document;
  }
}
