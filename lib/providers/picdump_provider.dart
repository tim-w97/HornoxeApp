import 'package:hornoxe_app/models/picdump.dart';
import 'package:hornoxe_app/services/crawler.dart';

class PicdumpProvider {
  final crawler = Crawler();

  late Stream<List<Picdump>> picdumps;
  late Future<List<String>> imageLinks;

  late Picdump currentPicdump;

  PicdumpProvider() {
    picdumps = crawler.picdumps;
  }

  void setImages({
    required Picdump ofPicdump,
  }) {
    currentPicdump = ofPicdump;
    imageLinks = crawler.fetchAllImageLinks(fromMainPicdumpUri: ofPicdump.uri);
  }
}
