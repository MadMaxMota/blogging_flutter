import 'package:flutter/material.dart';

class TextComposerScreen extends StatefulWidget {
  @override
  _TextComposerScreenState createState() => _TextComposerScreenState();
}

class _TextComposerScreenState extends State<TextComposerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(50, 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(42))),
                onPressed: () {},
                child: Text('Tweetar')),
          )
        ],
      ),
    );
  }
}
