import 'package:blogging_flutter/login_screnn.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
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
        iconTheme: IconThemeData(color: Colors.blue, size: 15),
      ),
      home: LoginScreen(),
    );
  }
}
