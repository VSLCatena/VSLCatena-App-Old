
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vsl_catena/models/promo.dart';
import 'package:vsl_catena/utils/firebase_fetcher.dart';

class PromoFetcher extends FirebaseFetcher<Promo> {

  PromoFetcher(): super("promo", "date", orderDescending: true);

  @override
  Promo convert(DocumentSnapshot snapshot) {
    return Promo.fromSnapshot(snapshot);
  }
}