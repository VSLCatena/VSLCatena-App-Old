import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ItemFetcher<T> {
  final DocumentReference _reference;
  bool _hasFetched = false;
  T item;

  ItemFetcher(this._reference);

  Future<T> get() async {
    if (_hasFetched) return item;
    
    final document = await _reference.get();
    item = convert(document);
    _hasFetched = true;
    return item;
  }

  T convert(DocumentSnapshot snapshot);
}