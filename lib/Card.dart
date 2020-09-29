import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barcode/barcode.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'showCard.dart';

class MyCardWidget extends StatelessWidget {
  var elCard;

  MyCardWidget(MyCard card) {
    elCard = card;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ShowCard(elCard),
            ));
      },
      child: Container(
        height: 140,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              child: Image.network('https://magnit.ru/favicon.ico?v=2'),
            ),
            Text(
              elCard.name,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}

class ShowCardWidget extends StatelessWidget {
  var elCard;

  ShowCardWidget(MyCard card) {
    elCard = card;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SvgPicture.string(
          Barcode.ean13().toSvg(elCard.code, width: 300, height: 200)),
    );
  }
}

class MyCard {
  String name;
  String code;
  MyCard(String name, String code) {
    this.name = name;
    this.code = code;
  }

  MyCardWidget getCardWidget() {
    return MyCardWidget(this);
  }

  ShowCardWidget showCardWidget() {
    return ShowCardWidget(this);
  }
}
