import 'package:flutter/material.dart';

import 'package:vsl_catena/models/promo.dart';
import 'package:vsl_catena/widgets/generic_banner.dart';

class PromoItem extends StatefulWidget {
  final Promo promo;

  PromoItem(this.promo);


  @override
  _PromoItem createState() => _PromoItem();
}

class _PromoItem extends State<PromoItem> {

  @override
  Widget build(BuildContext context) {
    final promo = widget.promo;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GenericBanner(
              promo.title,
              promo.user, promo.date.seconds,
              promo.userLastEdited, promo.dateLastEdited?.seconds
          ),
          Padding(
              padding: EdgeInsets.all(8),
              child: Text(widget.promo.content)
          )
        ]
    );
  }
}