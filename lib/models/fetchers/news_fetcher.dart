
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vsl_catena/models/news.dart';
import 'package:vsl_catena/utils/firebase_fetcher.dart';

class NewsFetcher extends FirebaseFetcher<News> {

  NewsFetcher(): super("news", "date", orderDescending: true);

  @override
  News convert(DocumentSnapshot snapshot) {
    return News.fromSnapshot(snapshot);
  }
}