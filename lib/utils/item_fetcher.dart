import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class ItemFetcher<T> {
  T item;
  final DocumentReference _reference;
  bool isLoading = false;
  bool isDone = false;
  ValueChanged<T> _onChange;
  

  ItemFetcher(this._reference);

  void observe(ValueChanged<T> onChange) {
    _onChange = onChange;
    fetch();
  }

  void observeIfNeeded(ValueChanged<T> onChange) {
    if (isDone) return;
    
    observe(onChange);
  }

  void _callOnChange(T item) {
    if (_onChange != null) {
      _onChange(item);
    }
    _onChange = null;
  }

  T convert(DocumentSnapshot snapshot);

  fetch() async {
    if (isDone) {
      _callOnChange(item);
    }

    if (isLoading || isDone) return;

    isLoading = true;

    var snapshot = await _reference.get();
    item = convert(snapshot);

    isDone = true;
    isLoading = false;

    _callOnChange(item);
  }
}