import 'package:hive_flutter/hive_flutter.dart';
import 'package:link_qr/save.dart';

import 'scanner.dart';
import 'package:flutter/material.dart';

void main() async{
  await Hive.initFlutter();
  await Hive.openBox('testBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Scanner App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 100),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: 5),
                    height: 80,
                    width: 150,
                    color: Colors.red,
                    child: Column(
                      children: [
                        Text(
                          'Total Data',
                          style: TextStyle(
                              color: Color(0xff010133),
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '50',
                          style: TextStyle(
                              color: Color(0xff010133),
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 80,
                    width: 150,
                    color: Colors.red,
                    child: Column(
                      children: [
                        Text(
                          'Saved Data',
                          style: TextStyle(
                              color: Color(0xff010133),
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '10',
                          style: TextStyle(
                              color: Color(0xff010133),
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    height: 80,
                    width: 150,
                    color: Colors.red,
                    child: Column(
                      children: [
                        Text(
                          'Rejected Data',
                          style: TextStyle(
                              color: Color(0xff010133),
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '5',
                          style: TextStyle(
                              color: Color(0xff010133),
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 80,
                    width: 150,
                    color: Colors.red,
                    child: Column(
                      children: [
                        Text(
                          'My Profile',
                          style: TextStyle(
                              color: Color(0xff010133),
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
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
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Text(
                        'Scan',
                        style: TextStyle(
                            color: Color(0xff010133),
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                       Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Save()),
                      );

                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 5),
                      height: 50,
                      width: 250,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Text(
                        'Saved List',
                        style: TextStyle(
                            color: Color(0xff010133),
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
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Text(
                      'Rejected List',
                      style: TextStyle(
                          color: Color(0xff010133),
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    height: 50,
                    width: 250,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Text(
                      'Logout',
                      style: TextStyle(
                          color: Color(0xff010133),
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
