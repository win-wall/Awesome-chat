import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_chat_app/Screens/chat_screen_2.dart';
import 'package:awesome_chat_app/Screens/seach_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class result_User extends StatefulWidget {
  result_User(this._a);
  Map _a;
  @override
  _result_UserState createState() => _result_UserState(_a);
}

class _result_UserState extends State<result_User> {
  Map _a;
  _result_UserState(this._a);
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
                        _a['name'],
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
                      _a['email'],
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ChatScreens(
                                          user: _a['name'],
                                        )))
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