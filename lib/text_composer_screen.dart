import 'package:flutter/material.dart';

class TextComposerScreen extends StatefulWidget {
  @override
  _TextComposerScreenState createState() => _TextComposerScreenState();
}

class _TextComposerScreenState extends State<TextComposerScreen> {
  bool _isComposing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
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
        body: Column(
          children: [
            Divider(height: 3, color: Colors.grey),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 50),
                  child: CircleAvatar(),
                ),
                Expanded(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'O que você está acontecendo?'),
                        onChanged: (text) {
                          setState(() {
                            _isComposing = text.isNotEmpty;
                          });
                        },
                        onSubmitted: (text) {},
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.photo_camera), onPressed: () {}),
                        IconButton(icon: Icon(Icons.photo), onPressed: () {}),
                      ],
                    ),
                  ],
                ))
              ],
            )
          ],
        ));
  }
}
