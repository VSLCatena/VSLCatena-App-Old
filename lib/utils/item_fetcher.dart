import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class ItemFetcher<T> {
  final DocumentReference _reference;
  List<ValueChanged<T>> _listeners = List();
  StreamSubscription<DocumentSnapshot> _subscription;
  
  T item;

  ItemFetcher(this._reference);

  void _onChange(DocumentSnapshot document) {
    item = convert(document);
    _listeners.forEach((listener) => listener(item));
  }

  void observe(ValueChanged<T> onChange) {
    if (onChange == null) return;
    _listeners.add(onChange);

    if (_subscription != null) return;
    _subscription = _reference.snapshots().listen(_onChange);
  }

  Future<T> get() async {
    if (item != null) return item;
    
    final document = await _reference.get();
    item = convert(document);
    return item;
  }

  void dispose() {
    _subscription.cancel();
  }

  T convert(DocumentSnapshot snapshot);
}