import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  Post(this.data, this.userData);

  DateTime time = new DateTime(2021);

  final Map<String, dynamic> data;
  final Map<String, dynamic> userData;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
                backgroundImage: NetworkImage(userData['senderPhotoUrl'])),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(userData['senderName'],
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold)),
                  ),
                  GestureDetector(
                    child: data['imgUrl'] != null
                        ? Image.network(data['imgUrl'], width: 200, height: 200)
                        : Text(data['text'], style: TextStyle(fontSize: 19)),
                    onLongPress: () {},
                  ),
                ],
              ),
            ),
          ),
          Divider(height: 3, color: Colors.grey)
        ],
      ),
    );
  }
}
