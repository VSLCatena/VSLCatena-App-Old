import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vsl_catena/utils/item_fetcher.dart';

class User {
  String name;
  int role;

  User(this.name, this.role);

  User.fromSnapshot(DocumentSnapshot snapshot)
    : name = snapshot["name"],
      role = snapshot["role"];
}

class UserFetcher extends ItemFetcher<User> {

  UserFetcher(DocumentReference reference): super(reference);

  @override
  User convert(DocumentSnapshot snapshot) {
    return User.fromSnapshot(snapshot);
  }
}