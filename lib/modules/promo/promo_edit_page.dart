import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:vsl_catena/models/news.dart';
import 'package:vsl_catena/translation/localization.dart';


class PromoEditPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _PromoEditState();
}

class _PromoEditState extends State<PromoEditPage> {

  String _title = "";
  String _content = "";

  void _onSubmit() async {
    final userId = FirebaseAuth.instance.currentUser.uid;
    FirebaseFirestore.instance.collection('promo').doc()
        .set({
      'title': _title,
      'content': _content,
      'user': userId,
      'date': Timestamp.now()
    });
  }

  @override
  Widget build(BuildContext context) {
    final News news = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text(Localization.of(context).get("promo_new_item")),
        ),
        body: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(8),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: Localization.of(context).get('general_input_title')
                  ),
                  initialValue: news?.title ?? "",
                  onChanged: (newValue) => _title = newValue,
                )
            ),
            Padding(
                padding: EdgeInsets.all(8),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: Localization.of(context).get('general_input_message')
                  ),
                  initialValue: news?.content ?? "",
                  onChanged: (newValue) => _content = newValue,
                )
            ),
            Row(
              children: [
                Padding(
                    padding: EdgeInsets.all(8),
                    child: RaisedButton(
                      padding: EdgeInsets.all(8),
                      child: Text(Localization.of(context).get('general_input_post')),
                      onPressed: _onSubmit,
                    )
                ),
              ],
            )
          ],
        )
    );
  }
}