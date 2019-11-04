import 'package:flutter/material.dart';

import 'package:vsl_catena/modules/news/widgets/news_item.dart';
import 'package:vsl_catena/models/news.dart';
import 'package:vsl_catena/translation/localization.dart';


class NewsItemPage extends StatelessWidget {

  void onSubmit() {

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
              labelText: Localization.of(context).get('login_password')
            ),
          )
        ),
       ],
     )
   );
 } 
}