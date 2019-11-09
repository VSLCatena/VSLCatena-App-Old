import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    _uid = (await FirebaseAuth.instance.currentUser())?.uid;

    if (_uid == null) return;

    Firestore.instance.document("users/$_uid").snapshots().listen(_onSnapshot);
  }

  void _onSnapshot(DocumentSnapshot document) {
    _currentUser = User.fromSnapshot(document);
    notifyListeners();
  }
}