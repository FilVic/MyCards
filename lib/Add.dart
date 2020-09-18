import 'package:flutter/material.dart';

import 'package:barcode_scan/barcode_scan.dart';

class MyAddPage extends StatefulWidget {
  MyAddPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyAddPageState createState() => _MyAddPageState();
}

class _MyAddPageState extends State<MyAddPage> {
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
        _strRes = 'Не разрешен доступ к камере!';
      } else {
        _strRes = e.code;
      }
    }
    _setRes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
