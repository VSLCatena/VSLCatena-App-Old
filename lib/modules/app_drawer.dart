import 'package:flutter/material.dart';
import 'package:vsl_catena/translation/localization.dart';


 class AppDrawer {
  static Widget createDrawer(BuildContext context) {
    var drawer = Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Image(image: AssetImage('assets/logo.png')),
          ),
          ListTile(
            title: Text(Localization.of(context).get("drawer_news")),
            onTap: () {
              navigateTo(context, '/');
            },
          ),
          ListTile(
            title: Text(Localization.of(context).get("drawer_promo")),
            onTap: () {
              navigateTo(context, '/promo');
            },
          ),
        ],
      ),
    );

    return drawer;
  }

  static void navigateTo(BuildContext context, String namedRoute) {
    if (namedRoute == "/") {
      Navigator.popUntil(context, (route) => route.isFirst);
      return;
    }
    Navigator.pushNamedAndRemoveUntil(context, namedRoute, (route) => route.isFirst);
  }

}