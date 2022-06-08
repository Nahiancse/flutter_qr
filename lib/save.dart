import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Save extends StatefulWidget {
  Save({this.data});
  String? data;

  @override
  State<Save> createState() => _SaveState();
}

class _SaveState extends State<Save> {
  late final Box scanbox;

  @override
  void initState() {
    super.initState();
    // Get reference to an already opened box
    scanbox = Hive.box('testBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder(
      valueListenable: scanbox.listenable(),
      builder: (ontext, Box box, widget) {
        var name = scanbox.get('scandata');
        return Text(name,style: TextStyle(fontSize: 18),);
      },
    ));
  }
}
