import 'package:Cards/Card.dart';
import 'package:flutter/material.dart';

import 'package:barcode_scan/barcode_scan.dart';

class MyAddPage extends StatefulWidget {
  @override
  _MyAddPageState createState() => _MyAddPageState();
}

class _MyAddPageState extends State<MyAddPage> {
  var nameController = TextEditingController();
  var codeController = TextEditingController();
  String _strRes = '';

  MyCard card;

  void _setRes() {
    setState(() {
      codeController.text = _strRes;
    });
  }

  Future _scanQR() async {
    ScanResult _resScan;
    try {
      _resScan = await BarcodeScanner.scan();
      _strRes = _resScan.rawContent;
      if (_strRes == '') {
        _strRes = 'Not scanned';
      }
    } catch (e) {
      if (e.code == 'PERMISSION_NOT_GRANTED') {
        _strRes = 'Permission not granted!';
      } else {
        _strRes = e.code;
      }
    }
    _setRes();
  }

  var _isName = true;
  var _isCode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add card'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                errorText: !_isName ? 'should fill name!' : null,
              ),
              maxLength: 20,
              controller: nameController,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Code (Scan or Edit)',
                errorText: !_isCode ? 'should fill code!' : null,
              ),
              controller: codeController,
            ),
            RaisedButton(
              onPressed: _scanQR,
              child: Text('Scan'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (nameController.text.isEmpty) {
            setState(() {
              _isName = false;
            });
            return;
          } else {
            setState(() {
              _isName = true;
            });
          }

          if (codeController.text.isEmpty) {
            setState(() {
              _isCode = false;
            });
            return;
          } else {
            setState(() {
              _isCode = true;
            });
          }
          card = MyCard(nameController.text, codeController.text);
          Navigator.pop(
            context,
            card,
          );
        },
        label: Text("Save"),
        icon: Icon(Icons.save),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
