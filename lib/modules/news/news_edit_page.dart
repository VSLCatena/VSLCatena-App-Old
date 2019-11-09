import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:vsl_catena/models/news.dart';
import 'package:vsl_catena/translation/localization.dart';


class NewsEditPage extends StatelessWidget {

  void _onSubmit() async {
    final userId = (await FirebaseAuth.instance.currentUser()).uid;
    Firestore.instance.collection('news').document()
      .setData({ 
        'title': 'title', 
        'content': 'testestes',
        'user': userId,
        'userLastEdited': userId,
        'date': 0,
        'dateLastEdited': 0
      });
  }

  @override  
 Widget build(BuildContext context) {
  final News news = ModalRoute.of(context).settings.arguments;
  
   return Scaffold(  
     appBar: AppBar(  
       title: Text(Localization.of(context).get("news_new_item")),  
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
          )
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: Localization.of(context).get('general_input_message')
            ),
            initialValue: news?.content ?? "",
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