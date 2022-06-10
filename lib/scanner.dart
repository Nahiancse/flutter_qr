import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:link_qr/home.dart';
import 'package:link_qr/main.dart';
import 'package:link_qr/reject.dart';
import 'package:link_qr/save.dart';
import 'package:link_qr/savee.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  late final Box scanbox;
  List<Map<String, dynamic>> _items = [];
  List<Map<String, dynamic>> _items2 = [];
  var a = 1;
  var b = 1;
  final _scanbox = Hive.box('testBox');
  final _scanbox2 = Hive.box('testBox2');

  /////////////////////hive////////////////////////////
  // Get all items from the database
  void _refreshItems() {
    final data = _scanbox.keys.map((key) {
      final value = _scanbox.get(key);
      return {"key": key, "name": value["name"], "quantity": value['quantity']};
    }).toList();

    //for reject
    final data2 = _scanbox2.keys.map((key) {
      final value2 = _scanbox2.get(key);
      return {
        "key": key,
        "name": value2["name"],
        "quantity": value2['quantity']
      };
    }).toList();

    setState(() {
      _items = data.reversed.toList();
      _items2 = data2.reversed.toList();
      // we use "reversed" to sort items in order from the latest to the oldest
    });
  }

  // Create new item
  Future<void> _createItem(Map<String, dynamic> newItem) async {
    await _scanbox.add(newItem);
    _refreshItems(); // update the UI
  }

  // Create new reject item
  Future<void> _createItem2(Map<String, dynamic> newItem) async {
    await _scanbox2.add(newItem);
    _refreshItems(); // update the UI
  }

  /////////////////////hive////////////////////////////

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Get reference to an already opened box
    scanbox = Hive.box('testBox');
    _refreshItems(); // Load data when app starts
  }

//   void _showForm(BuildContext ctx, int? itemKey, Barcode scandata) async {
//     // itemKey == null -> create new item
//     // itemKey != null -> update an existing item
    
      
      
//         if(_scanbox.containsKey(itemKey)==itemKey){
//           ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('An item has been deleted')));
//         }
//         else{
//  _createItem({"name": a, "quantity": scandata});
//         a++;
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => MyHomePage()),
//         );
//         }
       
   
    
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Scanner"),
      ),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                    ),
                    Center(
                      child: Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.red,
                            width: 4,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text('Scan a code'),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(
    QRViewController controller,
  ) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      if (await canLaunch(scanData.code!)) {
        await launch(scanData.code!);
        controller.resumeCamera();
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Result'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Barcode Type: ${describeEnum(scanData.format)}'),
                    Text('Data: ${scanData.code}'),
                  ],
                ),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      child: Text('Save'),
                      onPressed: () async {
                        _createItem({"name": a, "quantity": scanData.code});
                        a++;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                        );
                      },
                    ),
                    TextButton(
                      child: Text('Reject'),
                      onPressed: () async {
                        _createItem2({"name": b, "quantity": scanData.code});
                        b++;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ).then((value) => controller.resumeCamera());
      }
    });
  }
}
