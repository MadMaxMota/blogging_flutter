import 'package:blogging_flutter/feed_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
  QuerySnapshot snapshot =
      await Firestore.instance.collection("col").getDocuments();
  snapshot.documents.forEach((d) {
    print(d.data);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
        bottomAppBarTheme: BottomAppBarTheme(color: Colors.blue),
        brightness: Brightness.light,
        primaryIconTheme: IconThemeData(color: Colors.blue),
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      home: FeedScreen(),
    );
  }
}
