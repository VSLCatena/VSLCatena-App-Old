import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:vsl_catena/translation/localization.dart';
import 'package:http/http.dart' as http;


class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _LoginPage createState() => _LoginPage();
}


class _LoginPage extends State<LoginPage> {

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _onLogin() async {
    await FirebaseAuth.instance.signInAnonymously();
    _checkIfLoggedIn();
//    _doLoginCall();
//    await FirebaseAuth.instance.signInAnonymously();
    // TODO update UserProvider
//    Navigator.popAndPushNamed(
//      context,
//      '/news'
//    );
  }

  @override
  void initState() {
    super.initState();

    _checkIfLoggedIn();
  }

  void _checkIfLoggedIn() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      Navigator.popAndPushNamed(
        context,
        '/news'
      );
    }
  }

  void _doLoginCall() async {
    var response = http.post(
        Uri.encodeFull("----"),
        body: {
          "username": _usernameController.text,
          "password": _passwordController.text,
        },
        headers: { "Accept": "application/json" }
    );

    await response;

  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text(Localization.of(context).get('login_title')),
     ),
     body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Padding(
           padding: EdgeInsets.all(8),
           child: Image(image: AssetImage('assets/logo.png'))
         ),
         Column(
             children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: Localization.of(context).get('login_username')
                  ),
                )
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: Localization.of(context).get('login_password')
                  ),
                )
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: RaisedButton(
                      padding: EdgeInsets.all(8),
                      onPressed: _onLogin,
                      child: Text(Localization.of(context).get('login_login'))
                    )
                  ),
                ],
              )
            ],
           ),
       ],
     ),
   );
 }

}