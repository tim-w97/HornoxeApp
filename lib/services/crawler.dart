import 'dart:convert';
import 'dart:typed_data';
import 'package:hornoxe_app/models/picdump.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';

class Crawler {
  Stream<List<Picdump>> get picdumps async* {
    Uri picdumpsUri = Uri.https("hornoxe.com", "picdumps");
    Document document = await _getDocument(forUri: picdumpsUri);

    List<Element> links = document.querySelectorAll(
      ".storytitle a:not([title*=Gifdump])[href]",
    );

    List<Picdump> picdumps = [];

    for (Element link in links) {
      Element? thumbnail =
          link.parent?.nextElementSibling?.querySelector(".content_thumb");

      picdumps.add(
        Picdump(
          uri: Uri.parse(link.attributes["href"]!),
          thumbnailLink: thumbnail?.attributes["src"],
          hash: link.text.split(" ").last,
        ),
      );
      yield picdumps;
    }
  }

  Stream<List<String>> fetchAllImageLinks({
    required Uri fromMainPicdumpUri,
  }) async* {
    List<Uri> pageLinks =
        await _fetchPageLinks(fromMainPicdumpUri: fromMainPicdumpUri);

    List<String> allImageLinks = [];

    allImageLinks.addAll(await _fetchImageLinks(fromUri: fromMainPicdumpUri));

    yield allImageLinks;

    for (Uri pageLink in pageLinks) {
      allImageLinks.addAll(await _fetchImageLinks(fromUri: pageLink));
      yield allImageLinks;
    }
  }

  Future<List<String>> _fetchImageLinks({required Uri fromUri}) async {
    Document document = await _getDocument(forUri: fromUri);

    List<String> imageUrls = document
        .querySelectorAll("img[title^=picdump][src]")
        .map((element) => element.attributes["src"]!)
        .toList();

    return imageUrls;
  }

  Future<List<Uri>> _fetchPageLinks({
    required Uri fromMainPicdumpUri,
  }) async {
    Document document = await _getDocument(forUri: fromMainPicdumpUri);

    List<Uri> pageLinks = document
        .querySelectorAll(".ngg-navigation .page-numbers[href]")
        .map((element) => element.attributes["href"]!)
        .map((pathWithQueryParam) =>
            Uri.parse("https://www.hornoxe.com$pathWithQueryParam"))
        .toList();

    return pageLinks;
  }

  Future<Document> _getDocument({required Uri forUri}) async {
    Response response = await get(forUri);

    Uint8List bytes = response.bodyBytes;
    String html = utf8.decode(bytes, allowMalformed: true);
    Document document = parse(html, encoding: "utf-8");

    return document;
  }
}
