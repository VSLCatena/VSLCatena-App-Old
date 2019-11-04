import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vsl_catena/models/user.dart';

class News {
  String title, content;
  UserFetcher user;

  News(this.title, this.content, this.user);

  News.fromSnapshot(DocumentSnapshot snapshot)
    : title = snapshot["title"],
      content = snapshot["content"],
      user = UserFetcher(snapshot["user"]);
}