import 'package:flutter/material.dart';

import 'Add.dart';

import 'about.dart';

import 'Card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Cards'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

List<MyCard> cardsList = new List();

void addCard(MyCard _card) {
  cardsList.add(_card);
}

class _MyHomePageState extends State<MyHomePage> {
  void _setCardsList() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(fontSize: 26),
                )),
            ListTile(
              title: Text('Add'),
              onTap: () async {
                MyCard res = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => MyAddPage(),
                    ));
                if (res is MyCard) {
                  cardsList.add(res);
                }
                setState(() {});
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('About App'),
              onTap: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => AboutPage(),
                    ));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: cardsList.length,
          itemBuilder: (BuildContext context, int index) {
            return cardsList[index].getCardWidget();
          }),
    );
  }
}
