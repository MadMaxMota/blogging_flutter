import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'text_composer_screen.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  void _postInFeed({String text, File imgFile}) async {
    Map<String, dynamic> data = {};

    if (imgFile != null) {
      StorageUploadTask task = FirebaseStorage.instance
          .ref()
          .child(DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(imgFile);

      StorageTaskSnapshot taskSnapshot = await task.onComplete;
      String url = await taskSnapshot.ref.getDownloadURL();
      data['imgUrl'] = url;
      print(url);
    }
    if (text != null) data['text'] = text;

    Firestore.instance.collection('publicações').add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pagina inicial')),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream:
                      Firestore.instance.collection('publicações').snapshots(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case (ConnectionState.none):
                      case (ConnectionState.waiting):
                        return Center(child: CircularProgressIndicator());
                      default:
                        List<DocumentSnapshot> documents =
                            snapshot.data.documents.reversed.toList();

                        return ListView.builder(
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(documents[index].data['text']),
                            );
                          },
                        );
                    }
                  }))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TextComposerScreen(_postInFeed)),
          );
        },
      ),
    );
  }
}
