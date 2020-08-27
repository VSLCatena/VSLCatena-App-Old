
import 'package:flutter/cupertino.dart';
import 'package:vsl_catena/models/user.dart';

class UserWidget extends StatefulWidget {
  final UserFetcher _userFetcher;

  const UserWidget(this._userFetcher);

  @override
  State<StatefulWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget._userFetcher?.get(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          var name = snapshot.data?.name;
          if (name == "") name = null;
          
          return Text(name ?? "??????");
        });
  }
}