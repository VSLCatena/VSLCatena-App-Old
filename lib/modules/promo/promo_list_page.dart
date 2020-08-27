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


class PromoListPage extends StatefulWidget {
  PromoListPage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _PromoListPageState createState() => _PromoListPageState();
}

class _PromoListPageState extends State<PromoListPage> {

  PromoFetcher _promoFetcher;
  ScrollController _scrollController = ScrollController();
  RefreshController _refreshController = RefreshController(initialRefresh: true);

  _PromoListPageState() {
    _promoFetcher = PromoFetcher();

    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.20;
      if (maxScroll - currentScroll <= delta) {
        _load();
      }
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   newsFetcher.fetch();
  // }

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
          title: Text(Localization.of(context).get("promo_title")),
        ),
        drawer: AppDrawer.createDrawer(context),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: () => _refresh(),
          header: WaterDropMaterialHeader(backgroundColor: Theme.of(context).primaryColor),
          child: ListView.builder(
              controller: _scrollController,
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
        ),
        floatingActionButton: Consumer<UserProvider>(
            builder: (context, provider, child) {
              // If we're not admin, we just return an empty container
              // TODO check if the user is in any committee
              if (provider.currentUser?.role?.isAtLeast(Role.admin) != true) {
                return Container();
              }

              return FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: (){
                  Navigator.pushNamed(
                      context,
                      '/promo/edit/item',
                      arguments: null
                  );
                },
              );
            }
        )

    );
  }

}