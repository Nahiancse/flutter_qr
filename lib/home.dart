import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:link_qr/reject.dart';
import 'package:link_qr/savee.dart';
import 'package:link_qr/scanner.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> _items = [];
  List<Map<String, dynamic>> _items2 = [];

  final _scanbox = Hive.box('testBox');
  final _scanbox2 = Hive.box('testBox2');

  var a;
  var b;
  var c;

  @override
  void initState() {
    super.initState();
    _refreshItems(); // Load data when app starts
  }

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
       a = _items.length + _items2.length;
    b = _items.length ;
    c = _items2.length ;
      // we use "reversed" to sort items in order from the latest to the oldest
    });
  }

 

  ///////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.purple,
        // title: Text('Home page'),
      ),
      drawer: Drawer(
        backgroundColor: Colors.purple[100],
    child: ListView(
      // Important: Remove any padding from the ListView.
      // padding: EdgeInsets.only(top:),
      children: [
        const UserAccountsDrawerHeader( // <-- SEE HERE
          decoration: BoxDecoration(color: Colors.purple),
          accountName: Text(
            "Scanner",
            style: TextStyle(
              
              fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20
            ),
          ),
          accountEmail: Text(''
            // "pinkesh.earth@gmail.com",
            // style: TextStyle(
            //   fontWeight: FontWeight.bold,
            // ),
          ),
          // currentAccountPicture: FlutterLogo(),
        ),
        ListTile(
          
          leading: Icon(
            Icons.scanner,
          ),
          title: const Text('Scan',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),
          onTap: () {
             Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Scanner()),
                      );
            // Navigator.pop(context);
          },
        ),
        Divider(thickness: 1,),
        ListTile(
          leading: Icon(
            Icons.note,
          ),
          title: const Text('Saved List',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),
          onTap: () {
              Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
            // Navigator.pop(context);
          },
        ),
        Divider(thickness: 1,),
        ListTile(
          leading: Icon(
            Icons.notes
          ),
          title: const Text('Rejected List',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),
          onTap: () {
             Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RejectPage()),
                      );
            // Navigator.pop(context);
          },
        ),
        Divider(thickness: 1,),
        ListTile(
          leading: Icon(
            Icons.person,
          ),
          title: const Text('My Profile',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),
          onTap: () {
            // Navigator.pop(context);
          },
        ),
        Divider(thickness: 1,),
        ListTile(
          leading: Icon(
            Icons.logout,
          ),
          title: const Text('Logout',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),
          onTap: () {
            // Navigator.pop(context);
          },
        ),
      ],
    ),
  ),
      body: Container(
        // margin: EdgeInsets.only(top: 100),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 8,
          shadowColor: Colors.green,
          shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          ),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.center,
                      // margin: EdgeInsets.only(right: 5),
                      height: 80,
                      width: 170,
                      color: Colors.purple,
                      child: Column(
                        children: [
                          Text(
                            'Total Scan',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '$a',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 8,
          shadowColor: Colors.green,
          shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          ),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.center,
                      height: 80,
                      width: 170,
                      color: Colors.purple,
                      child: Column(
                        children: [
                          Text(
                            'Saved Data',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '$b',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 8,
          shadowColor: Colors.green,
          shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          ),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      // margin: EdgeInsets.only(right: 5),
                      height: 80,
                      width: 170,
                      color: Colors.purple,
                      child: Column(
                        children: [
                          Text(
                            'Rejected Data',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '$c',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 8,
          shadowColor: Colors.green,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.center,
                      height: 80,
                      width: 170,
                      color: Colors.purple,
                      child: Column(
                        children: [
                          Text(
                            'My Profile',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Scanner()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 5),
                      height: 50,
                      width: 250,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Text(
                        'Scan',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 5),
                      height: 50,
                      width: 250,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Text(
                        'Saved List',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RejectPage()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 5),
                      height: 50,
                      width: 250,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Text(
                        'Rejected List',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    height: 50,
                    width: 250,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Text(
                      'Logout',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
