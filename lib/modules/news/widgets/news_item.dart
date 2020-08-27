import 'package:flutter/material.dart';

import 'package:vsl_catena/models/news.dart';
import 'package:vsl_catena/widgets/generic_banner.dart';

class NewsItem extends StatefulWidget {
  final News news;

  NewsItem(this.news);


  @override
  _NewsItem createState() => _NewsItem();
}

class _NewsItem extends State<NewsItem> {

  @override
  Widget build(BuildContext context) {
    final news = widget.news;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GenericBanner(
            news.title,
            news.user, news.date.seconds,
            news.userLastEdited, news.dateLastEdited?.seconds
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(widget.news.content)
        )
      ]
    );
  }
}