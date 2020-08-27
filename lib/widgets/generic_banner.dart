import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';
import 'package:vsl_catena/models/user.dart';
import 'package:vsl_catena/translation/localization.dart';
import 'package:vsl_catena/utils/TimeUtils.dart';

class GenericBanner extends StatelessWidget {
  final String title;
  final UserFetcher user;
  final int date;
  final UserFetcher userEdited;
  final int dateEdited;

  GenericBanner(
      this.title,
      this.user,
      this.date,
      this.userEdited,
      this.dateEdited);

  @override
  Widget build(BuildContext context) {

    var children = List<Widget>();

    // User that posted
    children.add(_createText(context, this.user, this.date));

    // User that edited it
    if (this.userEdited != null) {
      children.add(_createText(
          context,
          this.userEdited,
          this.dateEdited,
          prefix: Localization.of(context).get("general_edited_by")
      ));
    }

    return ListTile(
          leading: FlutterLogo(),
          title: Text(this.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          )
      );
  }

  String _getName(String name) {
    if (name == null || name == "") return "??????";
    return name;
  }

  FutureBuilder<User> _createText(BuildContext context, UserFetcher fetcher, int date, { String prefix }) {
    return FutureBuilder(
        future: fetcher.get(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          // A prefix
          final children = List<Widget>();
          if (prefix != null) {
            children.add(Text(prefix + " "));
          }

          children.add(Text(
              _getName(snapshot.data?.name),
              style: TextStyle(fontWeight: FontWeight.bold)
          ));

          children.add(Text(" " + Localization.of(context).get("general_at") + " "));

          children.add(Text(
            TimeUtils.formatFull(date),
            style: TextStyle(fontStyle: FontStyle.italic),
          ));

          return Row(
            children: children
          );
        });
  }
}