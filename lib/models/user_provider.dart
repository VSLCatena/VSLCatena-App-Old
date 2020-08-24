import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:flutter/foundation.dart';
import 'package:vsl_catena/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _currentUser;
  String _uid;

  UserProvider() {
    startListening();
  }


  User get currentUser => _currentUser;
  String get currentUid => _uid;

  void startListening() async {
    _uid = fbAuth.FirebaseAuth.instance.currentUser.uid;

    if (_uid == null) return;

    FirebaseFirestore.instance.doc("users/$_uid").snapshots().listen(_onSnapshot);
  }

  void _onSnapshot(DocumentSnapshot document) {
    _currentUser = User.fromSnapshot(document);
    notifyListeners();
  }
}