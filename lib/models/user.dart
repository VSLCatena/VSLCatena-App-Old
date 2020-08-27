import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vsl_catena/utils/item_fetcher.dart';

class User {
  final String id;
  final String name;
  final Role role;

  User(this.id, this.name, this.role);

  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot == null) return null;

    return User(snapshot.id, snapshot.data()["name"], Role.fromLevel(snapshot.data()["role"]));
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
  static Map<String, UserFetcher> _pool = Map();

  UserFetcher(DocumentReference user): super(user);

  factory UserFetcher.get(DocumentSnapshot snapshot, String fieldId) {
    var userKey = snapshot.data()[fieldId];
    if (userKey == null) return null;

    String userId;
    // I want it to be flexible where it can both be a string as a reference
    if (userKey is String) {
      userId = userKey;
    } else if (userKey is DocumentReference) {
      userId = userKey.id;
    } else {
      // If it's neither a string or a reference we just return null
      return null;
    }

    if (!_pool.containsKey(userId)) {
      _pool[userId] = UserFetcher(FirebaseFirestore.instance.collection("users").doc(userId));
      _pool[userId].get();
    }

    return _pool[userId];
  }

  @override
  User convert(DocumentSnapshot snapshot) {
    return User.fromSnapshot(snapshot);
  }
}