import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HiveViewer extends StatelessWidget {
  final String boxName;

  HiveViewer(this.boxName);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox(boxName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var box = Hive.box(boxName);
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final key = box.keyAt(index);
              final value = box.get(key);
              return ListTile(
                title: Text('Key: $key'),
                subtitle: Text('Value: $value'),
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
