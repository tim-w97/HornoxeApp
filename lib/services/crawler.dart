import 'dart:convert';
import 'package:hornoxe_app/models/picdump.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';

class Crawler {
  Future<List<Picdump>> get picdumps async {
    final picdumpsUri = Uri.https("hornoxe.com", "picdumps");
    final document = await _getDocument(forUri: picdumpsUri);

    final links = document.querySelectorAll("a[title*='Picdump #']");

    final picdumps = links.map((link) {
      String hash = link.text.split(" ").last;
      String href = link.attributes["href"]!;

      return Picdump(
        uri: Uri.parse(href),
        thumbnailLink: "thumbnailLink",
        hash: hash,
        timestamp: "timestamp",
      );
    }).toList();

    return picdumps;
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
