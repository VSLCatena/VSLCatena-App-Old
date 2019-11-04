import 'package:flutter/material.dart';

import 'package:vsl_catena/models/news.dart';

class NewsItem extends StatefulWidget {
  final News news;

  NewsItem(this.news);

  @override
  _NewsItem createState() => _NewsItem();
}

class _NewsItem extends State<NewsItem> {
  
  _NewsItem();

  @override
  Widget build(BuildContext context) {
    widget.news.user.observeIfNeeded((item) { setState(() {});});

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: FlutterLogo(),
          title: Text(widget.news.title),
          subtitle: Text(widget.news.user.item?.name ?? "")
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(widget.news.content)
        )
      ]
    );
  }
}