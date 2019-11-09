import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vsl_catena/utils/item_fetcher.dart';

class User {
  String name;
  Role role;

  User(this.name, this.role);

  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot == null) return null;

    try {
      return User(snapshot["name"], Role.fromLevel(snapshot["role"]));
    } catch(e) {
      return User("", Role.user);
    }
  }
}

class Role { 
  final int level;

  const Role(this.level);

  factory Role.fromLevel(int level) {
    switch (level) {
      case 1: 
        return moderator;
      case 2:
        return admin;
      case 3:
        return superAdmin;
      default:
        return user;
    }
  }

  bool isAtLeast(Role role) {
    return level >= role.level;
  }

  static const user = Role(0);
  static const moderator = Role(1);
  static const admin = Role(2);
  static const superAdmin = Role(3);
}

class UserFetcher extends ItemFetcher<User> {

  UserFetcher(DocumentReference reference): super(reference);

  factory UserFetcher.fromReference(reference) {
    if (reference == null || !(reference is DocumentReference)) return null;

    return UserFetcher(reference);
  }

  @override
  User convert(DocumentSnapshot snapshot) {
    return User.fromSnapshot(snapshot);
  }
}