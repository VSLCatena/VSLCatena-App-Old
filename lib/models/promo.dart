import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vsl_catena/models/user.dart';

class Promo {
  String title, content;
  UserFetcher user, userLastEdited;
  Timestamp date, dateLastEdited;

  Promo(
      this.title,
      this.content,
      this.user,
      this.date,
      this.userLastEdited,
      this.dateLastEdited
      );

  Promo.fromSnapshot(DocumentSnapshot snapshot) : this(
      snapshot.data()["title"],
      snapshot.data()["content"],
      UserFetcher.get(snapshot, "user"),
      snapshot.data()['date'],
      UserFetcher.get(snapshot, 'userLastEdited'),
      snapshot.data()['dateLastEdited']
  );
}