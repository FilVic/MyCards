import 'package:Cards/Card.dart';
import 'package:flutter/material.dart';
import 'Card.dart';

class ShowCard extends StatelessWidget {
  MyCard elCard;

  ShowCard(MyCard card) {
    elCard = card;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(elCard.name),
      ),
      body: Container(
        alignment: Alignment.center,
        child: elCard.showCardWidget(),
      ),
    );
  }
}
