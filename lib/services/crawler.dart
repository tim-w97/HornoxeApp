import 'dart:convert';
import 'package:html/parser.dart';
import 'package:http/http.dart';

class Crawler {
  final _picdumpsUri = Uri.https("hornoxe.com", "picdumps");

  Future<List<String>> get imageLinks async {
    Uri hornoxeUri =
        Uri.parse("https://www.hornoxe.com/hornoxe-com-picdump-793/");

    final response = await get(hornoxeUri, headers: {"charset": "utf-8"});

    final bytes = response.bodyBytes;
    final html = utf8.decode(bytes, allowMalformed: true);
    final document = parse(html, encoding: "utf-8");

    final imageUrls = document
        .querySelectorAll("#ngg-gallery-1442-44481 img")
        .map((element) => element.attributes["src"]!)
        .toList();

    return imageUrls;
  }
}
