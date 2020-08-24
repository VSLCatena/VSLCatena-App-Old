import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vsl_catena/models/user.dart';

class News {
  String title, content;
  UserFetcher user, userLastEdited;
  Timestamp date, dateLastEdited;

  News(
    this.title, 
    this.content,
    this.user,
    this.date,
    this.userLastEdited,
    this.dateLastEdited
  );

  News.fromSnapshot(DocumentSnapshot snapshot)
    : this(
        snapshot.get("title"),
        snapshot.get("content"),
        UserFetcher.get(snapshot.get("user")),
        snapshot.get('date'),
        UserFetcher.get(snapshot.get('userLastEdited')),
        snapshot.get('dateLastEdited')
    );
}