import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vsl_catena/models/fetchers/promo_fetcher.dart';
import 'package:vsl_catena/models/promo.dart';
import 'package:vsl_catena/models/user.dart';
import 'package:vsl_catena/models/user_provider.dart';
import 'package:vsl_catena/modules/app_drawer.dart';

import 'package:vsl_catena/modules/news/widgets/news_item.dart';
import 'package:vsl_catena/models/news.dart';
import 'package:vsl_catena/modules/promo/widgets/promo_item.dart';
import 'package:vsl_catena/translation/localization.dart';
import 'package:vsl_catena/utils/firebase_fetcher.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PromoFetcher _promoFetcher;
  RefreshController _refreshController = RefreshController(initialRefresh: true);

  _HomePageState() {
    _promoFetcher = PromoFetcher();
  }

  void _refresh() async {
    _promoFetcher.reset();
    await _load();

    _refreshController.refreshCompleted();
  }

  Future<void> _load() async {
    await _promoFetcher.load();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Localization.of(context).get("title")),
        ),
        drawer: AppDrawer.createDrawer(context),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: () => _refresh(),
          header: WaterDropMaterialHeader(backgroundColor: Theme.of(context).primaryColor),
          child: ListView.builder(
              itemCount: _promoFetcher.items.length,
              padding: EdgeInsets.only(bottom: 80),
              itemBuilder: (context, index) {
                return Card(
                    child: InkWell(
                        child: PromoItem(_promoFetcher.items[index]),
                        onTap: () {
                          Navigator.pushNamed(
                              context,
                              '/news/item',
                              arguments: _promoFetcher.items[index]
                          );
                        }
                    )
                );
              }
          ),
        )
    );
  }
}