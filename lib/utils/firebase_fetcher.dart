import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

abstract class FirebaseFetcher<T> {
  String path, orderKey;
  int limit = 10;
  bool isLoading = false;
  Function stateSetter;

  FirebaseFetcher(this.path, this.orderKey, this.stateSetter, {this.limit = 10});

  List<T> items = []; // stores fetched items

  bool hasMore = true; // flag for more items available or not

  DocumentSnapshot
      lastDocument; // flag for last document from where next 10 records to be fetched

  fetch() async {
    if (!hasMore) {
      print('No More Items');
      return;
    }
    if (isLoading) {
      return;
    }
    stateSetter(() {
      isLoading = true;
    });

    var query = Firestore.instance
        .collection(this.path)
        .orderBy(this.orderKey)
        .limit(this.limit);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    var documents = (await query.getDocuments()).documents;

    if (documents.length < this.limit) {
      hasMore = false;
    }
    lastDocument = documents[documents.length - 1];
    items.addAll(
      documents
      .map((document) {
        try { 
          return convert(document); 
        } catch(e, s) {
          stderr.addError("Error converting documentSnapshot to object $e", s);
          return null; 
        } 
      })
      .where((item) => item != null)
    );

    stateSetter(() {
      isLoading = false;
    });
  }

  T convert(DocumentSnapshot snapshot);
}
