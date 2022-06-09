import 'package:hive_flutter/hive_flutter.dart';
import 'package:link_qr/home.dart';
import 'package:link_qr/save.dart';
import 'package:link_qr/savee.dart';

import 'scanner.dart';
import 'package:flutter/material.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('testBox');
  await Hive.openBox('testBox2');

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
      home: MyHomePage(),
    );
  }
}

