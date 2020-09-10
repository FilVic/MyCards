import 'package:flutter/material.dart';

import 'package:barcode_scan/barcode_scan.dart';

import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _resQR = 'Нажмите кнопку "Scan"';
  String _strRes = '';

  void _setRes() {
    setState(() {
      _resQR = _strRes;
    });
  }

  Future _scanQR() async {
    ScanResult _resScan;
    try {
      _resScan = await BarcodeScanner.scan();
      _strRes = _resScan.rawContent;
      if (_strRes == '') {
        _strRes = 'Не отсканирован код.';
      }
    } catch (e) {
      if (e.code == 'PERMISSION_NOT_GRANTED') {
        _strRes = 'Не разрешен доступ к камере.';
      } else {
        _strRes = e.code;
      }
    }
    _setRes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _resQR,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _scanQR,
        label: Text("Scan"),
        icon: Icon(Icons.camera),
        tooltip: 'Scan QR code',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
