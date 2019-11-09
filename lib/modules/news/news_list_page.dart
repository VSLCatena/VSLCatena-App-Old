import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vsl_catena/models/user.dart';
import 'package:vsl_catena/models/user_provider.dart';
import 'package:vsl_catena/modules/app_drawer.dart';

import 'package:vsl_catena/modules/news/widgets/news_item.dart';
import 'package:vsl_catena/models/news.dart';
import 'package:vsl_catena/translation/localization.dart';
import 'package:vsl_catena/utils/firebase_fetcher.dart';


class NewsListPage extends StatefulWidget {
  NewsListPage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {

  _NewsFetcher newsFetcher;
  ScrollController _scrollController = ScrollController();

  _NewsListPageState() {
     newsFetcher = _NewsFetcher(setState);

     _scrollController.addListener(() {  
      double maxScroll = _scrollController.position.maxScrollExtent;  
      double currentScroll = _scrollController.position.pixels;  
      double delta = MediaQuery.of(context).size.height * 0.20;  
      if (maxScroll - currentScroll <= delta) {  
        newsFetcher.fetch();  
      }  
    });  
  }

  @override
  void initState() {
    super.initState();
    newsFetcher.fetch();  
  }


  @override  
 Widget build(BuildContext context) {
    return Scaffold(  
      appBar: AppBar(  
        title: Text(Localization.of(context).get("news_title")),  
      ),  
      drawer: AppDrawer.createDrawer(context),
      body: Column(children: [
        Expanded(  
          child: newsFetcher.items.length == 0  
              ? Center(child: Text(Localization.of(context).get('general_no_data')))  
              : ListView.builder(  
                  controller: _scrollController,  
                  itemCount: newsFetcher.items.length,  
                  itemBuilder: (context, index) {  
                    return Card(
                      child: InkWell(
                        child: NewsItem(newsFetcher.items[index]),
                        onTap: () { 
                          Navigator.pushNamed(
                            context,
                            '/news/item',
                            arguments: newsFetcher.items[index]
                          );
                        }
                       )
                    );
                  },  
              ),  
        ),  
        newsFetcher.isLoading  
            ? Container(  
              width: MediaQuery.of(context).size.width,  
              padding: EdgeInsets.all(5),  
              color: Colors.yellowAccent,  
              child: Text(  
                Localization.of(context).get('general_loading'),  
                textAlign: TextAlign.center,  
                style: TextStyle(fontWeight: FontWeight.bold),  
              ),  
            )  
            : Container()  
      ]),  
      floatingActionButton: Consumer<UserProvider>(
        builder: (context, provider, child) {
          if (provider.currentUser?.role?.isAtLeast(Role.admin) == true) {
            return FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: (){
                Navigator.pushNamed(
                  context,
                  '/news/edit/item',
                  arguments: null
                );
              },
            );
          } else {
            return Container();
          }
        }
      )
   );
 } 
  
}

class _NewsFetcher extends FirebaseFetcher<News> {

  _NewsFetcher(Function stateSetter): super("news", "date", stateSetter);
  
  @override
  News convert(DocumentSnapshot snapshot) {
    return News.fromSnapshot(snapshot);
  }
}