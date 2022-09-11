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
        thumbnailLink: "images/dummy_thumbnail.jpeg",
        hash: hash,
        timestamp: "12.06.2022",
      );
    }).toList();

    return picdumps;
  }

  Future<List<String>> fetchAllImageLinks({
    required Uri fromMainPicdumpUri,
  }) async {
    final pageLinks =
        await _fetchPageLinks(fromMainPicdumpUri: fromMainPicdumpUri);

    List<String> allImageLinks = [];

    allImageLinks.addAll(await _fetchImageLinks(fromUri: fromMainPicdumpUri));

    for (Uri pageLink in pageLinks) {
      allImageLinks.addAll(await _fetchImageLinks(fromUri: pageLink));
    }

    return allImageLinks;
  }

  Future<List<String>> _fetchImageLinks({required Uri fromUri}) async {
    final document = await _getDocument(forUri: fromUri);

    final imageUrls = document
        .querySelectorAll("img[title^=picdump][src]")
        .map((element) => element.attributes["src"]!)
        .toList();

    return imageUrls;
  }

  Future<List<Uri>> _fetchPageLinks({
    required Uri fromMainPicdumpUri,
  }) async {
    final document = await _getDocument(forUri: fromMainPicdumpUri);

    final pageLinks = document
        .querySelectorAll(".ngg-navigation .page-numbers[href]")
        .map((element) => element.attributes["href"]!)
        .map((pathWithQueryParam) =>
            Uri.parse("https://www.hornoxe.com$pathWithQueryParam"))
        .toList();

    return pageLinks;
  }

  Future<Document> _getDocument({required Uri forUri}) async {
    final response = await get(forUri);

    final bytes = response.bodyBytes;
    final html = utf8.decode(bytes, allowMalformed: true);
    final document = parse(html, encoding: "utf-8");

    return document;
  }
}
