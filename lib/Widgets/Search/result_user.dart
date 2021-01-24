import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_chat_app/Models/user_model.dart';
import 'package:awesome_chat_app/Screens/chat_screen_2.dart';
import 'package:awesome_chat_app/Screens/seach_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class result_User extends StatefulWidget {
  result_User(this._a);
  User2 _a; //user khác
  @override
  _result_UserState createState() => _result_UserState(_a);
}

class _result_UserState extends State<result_User> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User2 _a;
  _result_UserState(this._a); //user khác
  String current_uid = '';
  void getuit() async {
    var number_msg;
    var user2 = auth.currentUser;
    var uid = user2.uid;
    current_uid = uid;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        alignment: Alignment(0, 0),
        child: Container(
          child: Card(
            color: Colors.blue,
            child: Stack(
              children: <Widget>[
                Container(
                    alignment: Alignment(0, 0.1),
                    child: Container(
                      alignment: Alignment(0, 0),
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: AutoSizeText(
                        _a.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.06,
                            color: Colors.white,
                            fontWeight: FontWeight.w300),
                        maxLines: 2,
                      ),
                    )),
                Container(
                  alignment: Alignment(0, 0.25),
                  child: Container(
                    alignment: Alignment(0, 0),
                    height: MediaQuery.of(context).size.height * 0.04,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: AutoSizeText(
                      _a.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                      maxLines: 2,
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment(-0.9, 0.95),
                    child: Container(
                        color: Colors.amber,
                        alignment: Alignment(0, 0),
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: FlatButton(
                          //! _trySubmit fuction
                          onPressed: () => {
                            getuit(),
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ChatScreens(
                                        //user khác
                                        user_uid: _a.uid, //user khác
                                        current_uid:
                                            current_uid, //user hiện tại
                                        username: _a.name))) //user khác
                          },
                          child: AutoSizeText(
                            'Send Message',
                            style:
                                TextStyle(fontSize: 100, color: Colors.white),
                            maxLines: 1,
                          ),
                        )))
              ],
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.9,
        ),
      ),
    );
  }
}
