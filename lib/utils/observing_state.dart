import 'package:flutter/widgets.dart';
import 'package:vsl_catena/utils/item_fetcher.dart';

mixin ObservingState<T extends StatefulWidget> on State<T> {

  List<ItemFetcher> _fetchers = new List();
  
  @override
  void dispose() {
    _fetchers.forEach((it) => it.dispose());
    super.dispose();
  }

  void observeStates(List<ItemFetcher> fetchers) {
    fetchers.forEach((it) => observeState(it));
  }

  void observeState(ItemFetcher fetcher) {
    if (fetcher == null) return;
    
    _fetchers.add(fetcher);
    fetcher.observe((_) => setState(() {}));
  }
}