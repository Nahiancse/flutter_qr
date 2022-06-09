import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RejectPage extends StatefulWidget {
  const RejectPage({ Key? key }) : super(key: key);

  @override
  State<RejectPage> createState() => _RejectPageState();
}

class _RejectPageState extends State<RejectPage> {
  List<Map<String, dynamic>> _items = [];

  final _scanbox = Hive.box('testBox2');

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

    setState(() {
      _items = data.reversed.toList();
      // we use "reversed" to sort items in order from the latest to the oldest
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rejected Data'),
      ),
      body: _items.isEmpty
          ? const Center(
              child: Text(
                'No Data',
                style: TextStyle(fontSize: 30),
              ),
            )
          : ListView.builder(
              // the list of items
              itemCount: _items.length,
              itemBuilder: (_, index) {
                final currentItem = _items[index];
                return Card(
                  color: Colors.orange.shade100,
                  margin: const EdgeInsets.all(10),
                  elevation: 3,
                  child: ListTile(
                      title: Text(currentItem['key'].toString()),
                      subtitle: Text(
                        currentItem['quantity'].toString(),
                        style: TextStyle(color: Colors.red),
                      ),
                  )
                );
              }),
      // Add new item button
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => _showForm(context, null),
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}