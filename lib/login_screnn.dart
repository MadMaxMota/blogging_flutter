import 'dart:ui';
import 'package:blogging_flutter/feed_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseUser _currentUser;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.onAuthStateChanged.listen((user) {
      _currentUser = user;
    });
  }

  Future<FirebaseUser> _getUser() async {
    if (_currentUser != null) return _currentUser;
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      final AuthResult authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;

      return user;
    } catch (error) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Image.asset(
              'lib/assets/twitter-logo-png.jpg',
              height: 100,
              width: 100,
            ),
            SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Text('Veja o o que está acontecendo no mundo agora',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 70),
            ElevatedButton(
                onPressed: () async {
                  final FirebaseUser user = await _getUser();
                  if (user == null) {
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      content: Text('Não foi possivél fazer o login.'),
                      backgroundColor: Colors.red,
                    ));
                  }
                  Map<String, dynamic> userData = {
                    'uid': user.uid,
                    'senderName': user.displayName,
                    'senderPhotoUrl': user.photoUrl,
                  };
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FeedScreen(userData: userData)));
                },
                child: Text('Continuar com o Google'))
          ],
        ),
      ),
    );
  }
}
