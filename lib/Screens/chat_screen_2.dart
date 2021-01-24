import 'package:awesome_chat_app/Models/message_model.dart';
import 'package:awesome_chat_app/Models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreens extends StatefulWidget {
  final User2 user;
  final String user_uid;
  final String current_uid;
  ChatScreens({this.user, this.user_uid, this.current_uid});

  @override
  _ChatScreensState createState() =>
      _ChatScreensState(this.user, this.user_uid, this.current_uid);
}

class _ChatScreensState extends State<ChatScreens> {
  User2 user;
  String text = '';
  String user_uid = '';
  String current_uid = '';
  Message2 msg;
  _ChatScreensState(this.user, this.user_uid, this.current_uid);
  final FirebaseAuth auth = FirebaseAuth.instance;

  void sendMsg() async {
    Message2 msg = Message2(
        receiver: user.uid,
        sender: current_uid,
        text: text,
        isLiked: false,
        isMe: true,
        unread: true,
        time: Timestamp.now());
    Message2 msg2 = Message2(
        receiver: user.uid,
        sender: current_uid,
        text: text,
        isLiked: false,
        isMe: false,
        unread: true,
        time: Timestamp.now());
    var map = msg.toMap();
    var map2 = msg2.toMap();
    print(current_uid);
    var number = await FirebaseFirestore.instance
        .collection('chats/${current_uid}/messages')
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot snap) => snap.data());
    print(user.uid);
    var number2 = await FirebaseFirestore.instance
        .collection('chats/${current_uid}/messages')
        .doc(user.uid)
        .collection('message')
        .get();

    print(number2.docs.length);

    await FirebaseFirestore.instance
        .collection('chats/${current_uid}/messages/')
        .doc(user.uid)
        .collection('message')
        .doc((number2.docs.length + 1).toString())
        .set(map);
    await FirebaseFirestore.instance
        .collection('chats/${current_uid}/messages/')
        .doc(user.uid)
        .set(map);
    await FirebaseFirestore.instance
        .collection('chats/${user.uid}/messages/')
        .doc(current_uid)
        .set(map2);
    await FirebaseFirestore.instance
        .collection('chats/${user.uid}/messages/')
        .doc(current_uid)
        .collection('message')
        .doc((number2.docs.length + 1).toString())
        .set(map2);
  }

  _buildMessage(Message2 message, bool isMe) {
    final msg = Container(
      margin: isMe
          ? EdgeInsets.only(top: 8, left: 80, right: 8)
          : EdgeInsets.only(top: 8, left: 8),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
          color: isMe ? Theme.of(context).accentColor : Colors.red,
          borderRadius: isMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))
              : BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat().format(message.time.toDate()),
            style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(message.text),
        ],
      ),
    );
    if (isMe) {
      return msg;
    }
    return Row(
      children: [
        msg,
        isMe
            ? SizedBox.shrink()
            : IconButton(
                icon: message.isLiked
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_border),
                iconSize: 30,
                color: message.isLiked ? Colors.red : Colors.blueGrey,
                onPressed: null)
      ],
    );
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70,
      color: Colors.white,
      child: Row(
        children: [
          IconButton(icon: Icon(Icons.photo), onPressed: null),
          Expanded(
              child: TextField(
            decoration:
                InputDecoration.collapsed(hintText: 'Send a message...'),
            onChanged: (vaule) {
              text = vaule;
            },
          )),
          IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                sendMsg();
              })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text(
            widget.user.name,
            textAlign: TextAlign.center,
          ),
          elevation: 0.0,
        ),
        body: Column(children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('chats/${current_uid}/messages/')
                    .doc(user.uid)
                    .collection('message')
                    .orderBy('time', descending: true)
                    .snapshots(),
                builder: (ctx, streamSnapshot) {
                  if (streamSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final documents = streamSnapshot.data.documents;

                  return /*ListView.builder(
                      itemCount: streamSnapshot.data.documents.length,
                      itemBuilder: (ctx, index) => Container(
                          padding: EdgeInsets.all(8),
                          child: Text(documents[index]['text'])));*/
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          child: ListView.builder(
                              reverse: true,
                              itemCount: streamSnapshot.data.documents.length,
                              itemBuilder: (BuildContext context, int index) {
                                String text = documents[index]['text'];
                                String sender = documents[index]['sender'];
                                String receiver = documents[index]['receiver'];
                                Timestamp time = documents[index]['time'];
                                bool isMe = documents[index]['isMe'];

                                msg = new Message2(
                                    text: text,
                                    sender: sender,
                                    receiver: receiver,
                                    time: time,
                                    isMe: isMe);

                                return _buildMessage(msg, isMe);
                              }));
                },

                /*child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  child: ListView.builder(
                    reverse: true,
                    padding: EdgeInsets.only(top: 15),
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Message message = messages[index];
                      final bool isMe = message.sender.id == currentUser.id;
                      return _buildMessage(message, isMe);
                    },
                  ),
                ),*/
              ),
            ),
          ),
          _buildMessageComposer(),
        ]),
      ),
    );
  }
}
