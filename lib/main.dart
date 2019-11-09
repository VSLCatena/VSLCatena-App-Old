import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vsl_catena/models/user_provider.dart';
import 'package:vsl_catena/modules/login/login_page.dart';
import 'package:vsl_catena/modules/news/news_edit_page.dart';
import 'package:vsl_catena/modules/news/news_item_page.dart';
import 'package:vsl_catena/modules/news/news_list_page.dart';
import 'package:vsl_catena/translation/localization.dart';

void main() => runApp(
  ChangeNotifierProvider(
    builder: (context) => UserProvider(),
    child: MyApp()
  )
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (BuildContext context) => Localization.of(context).get('title'),
      localizationsDelegates: [
        const LocalizationDelegate()
      ],
      routes: {
        '/': (context) => LoginPage(),
        '/news': (context) => NewsListPage(),
        '/news/item': (context) => NewsItemPage(),
        '/news/edit/item': (context) => NewsEditPage()
      },
      supportedLocales: [
        const Locale('nl', ''),
        const Locale('en', ''),
      ],
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.indigo,
      )
    );
  }
}

