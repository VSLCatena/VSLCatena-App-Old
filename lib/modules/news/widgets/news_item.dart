import 'package:flutter/material.dart';

import 'package:vsl_catena/models/news.dart';
import 'package:intl/intl.dart';
import 'package:vsl_catena/utils/observing_state.dart';

class NewsItem extends StatefulWidget {
  final News news;

  NewsItem(this.news);

  @override
  _NewsItem createState() => _NewsItem();
}

class _NewsItem extends State<NewsItem> with ObservingState {

  @override
  void initState() {
    observeStates([
      widget.news.user,
      widget.news.userLastEdited
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String formatTimestamp(int timestamp) {
      var format = new DateFormat('dd-mm-yyyy, HH:mm');
      var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      return format.format(date);
    }

    Widget editedAt = Container();
    if (widget.news.userLastEdited != null) {
      editedAt = Text(
        "Last edited at " + formatTimestamp(widget.news.dateLastEdited.seconds) + 
        " by " + (widget.news.userLastEdited?.item?.name ?? "")
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: FlutterLogo(),
          title: Text(widget.news.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.news.user.item?.name ?? ""),
              editedAt,
            ],
          )
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(widget.news.content)
        )
      ]
    );
  }
}