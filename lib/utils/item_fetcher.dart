import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class ItemFetcher<T> {
  final DocumentReference _reference;
  List<StreamSubscription> _subscriptions = List();
  
  T item;

  ItemFetcher(this._reference);

  void observe(ValueChanged<T> onChange) {
    if (onChange == null) return;

    _subscriptions.add(
      _reference.snapshots().listen(
        (DocumentSnapshot documentSnapshot) => onChange(convert(documentSnapshot))
      )
    );
  }

  Future<T> get() async {
    final document = await _reference.get();
    return convert(document);
  }

  void dispose() {
    _subscriptions.forEach((it) => it.cancel());
    _subscriptions.clear();
  }

  T convert(DocumentSnapshot snapshot);
}