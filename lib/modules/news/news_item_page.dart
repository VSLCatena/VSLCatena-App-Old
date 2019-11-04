import 'package:flutter/material.dart';

import 'package:vsl_catena/modules/news/widgets/news_item.dart';
import 'package:vsl_catena/models/news.dart';
import 'package:vsl_catena/translation/localization.dart';


class NewsItemPage extends StatelessWidget {
  @override  
 Widget build(BuildContext context) {
  final News news = ModalRoute.of(context).settings.arguments;
   return Scaffold(  
     appBar: AppBar(  
       title: Text(Localization.of(context).get("news_title")),  
     ),  
     body: NewsItem(news)
   );
 } 
}