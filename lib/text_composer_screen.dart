import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextComposerScreen extends StatefulWidget {
  TextComposerScreen(this.postInFeed);
  final Function({String text, File imgFile}) postInFeed;

  @override
  _TextComposerScreenState createState() => _TextComposerScreenState();
}

class _TextComposerScreenState extends State<TextComposerScreen> {
  final TextEditingController _controller = TextEditingController();
  final ImagePicker picker = ImagePicker();
  Map<String, dynamic> data = {};
  bool _isComposing = false;
  File imgFile;

  void reset() {
    _controller.clear();
    Navigator.pop(context);
    setState(() {
      _isComposing = false;
    });
  }

  String get text => null;
  Future getImage(bool isCamera) async {
    var pickedFile = await picker.getImage(
        source: (isCamera == true) ? ImageSource.camera : ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        imgFile = File(pickedFile.path);
      } else {
        print("No image selected.");
      }
    });
    if (pickedFile == null) {
      return false;
    } else {
      return true;
    }
  }

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
                child: Text('Postar'),
                onPressed: _isComposing
                    ? () {
                        widget.postInFeed(text: _controller.text);
                        reset();
                      }
                    : null,
              ),
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
                        controller: _controller,
                        decoration: InputDecoration(
                            hintText: 'O que está acontecendo?'),
                        onChanged: (text) {
                          setState(() {
                            _isComposing = text.isNotEmpty;
                          });
                        },
                        onSubmitted: (text) {
                          widget.postInFeed(text: text);
                          reset();
                        },
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.photo_camera),
                            onPressed: () async {
                              getImage(true).then((value) => {
                                    if (imgFile != null)
                                      {
                                        widget.postInFeed(imgFile: imgFile),
                                        Navigator.pop(context)
                                      }
                                  });
                            }),
                        IconButton(
                            icon: Icon(Icons.photo),
                            onPressed: () async {
                              getImage(false).then((value) => {
                                    if (imgFile != null)
                                      {
                                        widget.postInFeed(imgFile: imgFile),
                                        Navigator.pop(context),
                                      }
                                  });
                            }),
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
