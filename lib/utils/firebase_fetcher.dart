import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

abstract class FirebaseFetcher<T> {
  String path, orderKey;
  int limit = 10;
  bool orderDescending = false;
  List<T> items = []; // stores fetched items
  _Fetcher<T> fetcher;

  FirebaseFetcher(this.path, this.orderKey, {this.limit = 10, this.orderDescending = false}) {
    _resetFetcher();
  }

  void _resetFetcher() {
    fetcher = _Fetcher(this.path, this.orderKey, limit: this.limit, orderDescending: this.orderDescending);
    items = [];
  }

  T convert(DocumentSnapshot snapshot);

  Future<void> load() async {
    if (!fetcher.hasMore) return;

    final documents = await fetcher.fetchNext();
    if (documents == null) return;

    items.addAll(
      documents.map((item) {
        try {
          return convert(item);
        } catch(e, s) {
          stderr.addError("Error converting item to T: $e", s);
          return null;
        }
      })
      .where((item) => item != null)
    );
  }

  void reset() {
    _resetFetcher();
  }

}


class _Fetcher<T> {
  String path, orderKey;
  int limit = 10;
  bool orderDescending = false;
  bool isLoading = false;
  bool hasMore = true; // flag for more items available or not

  _Fetcher(this.path, this.orderKey, {this.limit = 10, this.orderDescending = false});

  DocumentSnapshot lastDocument; // flag for last document from where next 10 records to be fetched

  Future<List<DocumentSnapshot>> fetchNext() async {
    if (!hasMore) {
      print('No More Items');
      return null;
    }
    if (isLoading) {
      return null;
    }

    var query = Firestore.instance
        .collection(this.path)
        .orderBy(this.orderKey, descending: orderDescending)
        .limit(this.limit);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    var documents = (await query.getDocuments()).documents;

    if (documents.length < this.limit) {
      hasMore = false;
    }
    lastDocument = documents[documents.length - 1];

    return documents;
  }
}
