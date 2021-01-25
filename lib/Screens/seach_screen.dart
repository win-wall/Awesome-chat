import 'package:awesome_chat_app/Models/user_model.dart';
import 'package:awesome_chat_app/Widgets/Search/result_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _userEmail = '';
  bool _isSubmit = false;
  User2 user;
  Map a;
  FocusNode myFocusNode = new FocusNode();
  void getData() async {
    var userRef = await Firestore.instance
        .collection('users')
        .doc(_userEmail)
        .get()
        .then((DocumentSnapshot snap) => snap.data());
    if (userRef != null) {
      _isSubmit = true;
    } else if (userRef == null) _isSubmit = false;
    print(userRef);
    a = userRef;
    user =
        User2(name: a['name'], email: a['email'], uid: a['uid'], url: a['url']);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Form(
          child: Container(
            alignment: Alignment(0, -1),
            child: Container(
              alignment: Alignment(0, -1),
              height: MediaQuery.of(context).size.height * 0.1,
              child: TextField(
                focusNode: myFocusNode,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: 'Search user with email',
                    labelStyle: TextStyle(
                        color: myFocusNode.hasFocus
                            ? Color.fromRGBO(189, 143, 164, 1)
                            : Colors.white70)),
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  _userEmail = value;
                  setState(() {});
                },
              ),
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            iconSize: 30,
            color: Colors.white,
            onPressed: () => {getData()},
          ),
        ],
      ),
      body: _isSubmit
          ? Container(child: result_User(user) //truyền vào user khác,
              )
          : Text(''),
    );
  }
}
