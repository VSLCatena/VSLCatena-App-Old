import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vsl_catena/utils/item_fetcher.dart';

class User {
  String name;
  Role role;

  User(this.name, this.role);

  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot == null) return null;

    try {
      return User(snapshot.get("name"), Role.fromLevel(snapshot.get("role")));
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
  static Map<String, UserFetcher> _pool = Map();

  UserFetcher(DocumentReference user): super(user);
  
  factory UserFetcher.get(String userId) {
    if (userId == null) return null;

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