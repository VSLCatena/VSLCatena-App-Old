import 'package:flutter/material.dart';
import 'package:vsl_catena/models/promo.dart';

import 'package:vsl_catena/modules/promo/widgets/promo_item.dart';
import 'package:vsl_catena/translation/localization.dart';


class PromoItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Promo promo = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text(Localization.of(context).get("promo_title")),
        ),
        body: PromoItem(promo)
    );
  }
}