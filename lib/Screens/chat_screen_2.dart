import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_chat_app/Models/message_model.dart';
import 'package:awesome_chat_app/Models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreens extends StatefulWidget {
  final String user_uid;
  final String current_uid;
  final String username;
  final String url;
  final String senderurl;
  final String receiverurl;
  ChatScreens(
      {this.user_uid,
      this.current_uid,
      this.username,
      this.url,
      this.senderurl,
      this.receiverurl});

  @override
  _ChatScreensState createState() => _ChatScreensState(
      this.user_uid,
      this.current_uid,
      this.username,
      this.url,
      this.senderurl,
      this.receiverurl);
}

class _ChatScreensState extends State<ChatScreens> {
  String senderurl = '';
  String receiverurl = '';
  String text = '';
  String user_uid = '';
  String current_uid = '';
  String username = '';
  String url = '';

  Message2 msg;
  _ChatScreensState(this.user_uid, this.current_uid, this.username, this.url,
      this.receiverurl, this.senderurl);
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _field = TextEditingController();
  void ClearTextInput() {
    _field.clear();
  }

  void sendMsg() async {
    print('Hello' + user_uid);
    var Current_User_info = await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser.email)
        .get()
        .then((DocumentSnapshot snap) => snap.data());

    Message2 msg = Message2(
        receiver: user_uid,
        sender: current_uid,
        text: text,
        isLiked: false,
        isMe: true,
        unread: true,
        senderName: Current_User_info['name'],
        receiverName: username,
        time: Timestamp.now(),
        url: url,
        senderurl: senderurl,
        receiverurl: receiverurl);
    Message2 msg2 = Message2(
        receiver: user_uid,
        sender: current_uid,
        text: text,
        isLiked: false,
        isMe: false,
        unread: true,
        senderName: Current_User_info['name'],
        receiverName: username,
        time: Timestamp.now(),
        url: url,
        senderurl: senderurl,
        receiverurl: receiverurl);
    var map = msg.toMap();
    var map2 = msg2.toMap();
    print(current_uid);
    var number = await FirebaseFirestore.instance
        .collection('chats/${current_uid}/messages')
        .doc(user_uid)
        .get()
        .then((DocumentSnapshot snap) => snap.data());
    print(user_uid);
    var number2 = await FirebaseFirestore.instance
        .collection('chats/${current_uid}/messages')
        .doc(user_uid)
        .collection('message')
        .get();

    print(number2.docs.length);

    await FirebaseFirestore.instance
        .collection('chats/${current_uid}/messages/')
        .doc(user_uid)
        .collection('message')
        .doc((number2.docs.length + 1).toString())
        .set(map);
    await FirebaseFirestore.instance
        .collection('chats/${user_uid}/messages/')
        .doc(current_uid)
        .collection('message')
        .doc((number2.docs.length + 1).toString())
        .set(map2);
    await FirebaseFirestore.instance
        .collection('chats/${current_uid}/messages/')
        .doc(user_uid)
        .set(map);
    await FirebaseFirestore.instance
        .collection('chats/${user_uid}/messages/')
        .doc(current_uid)
        .set(map2);
  }

  _buildMessage(Message2 message) {
    final msg = Container(
      margin: message.isMe
          ? EdgeInsets.only(top: 8, left: 80, bottom: 8)
          : EdgeInsets.only(top: 8, bottom: 8, right: 80),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
          color: (message.isMe)
              ? Color.fromRGBO(95, 158, 160, 0.5)
              : Color.fromRGBO(158, 160, 95, 0.5),
          borderRadius: message.isMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))
              : BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
      child: Column(
        crossAxisAlignment:
            message.isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Text(
            DateFormat.Hms().format(message.time.toDate()),
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
    if (message.isMe) {
      return msg;
    }
    return Row(
      children: [
        msg,
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
          Expanded(
              child: TextField(
            controller: _field,
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
                ClearTextInput();
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
          centerTitle: true,
          title: Container(
            alignment: Alignment(-0.5, 0),
            child: Container(
              alignment: Alignment(0, 0),
              height: MediaQuery.of(context).size.height * 0.04,
              width: MediaQuery.of(context).size.width * 0.5,
              child: AutoSizeText(
                widget.username,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 100),
                maxLines: 1,
              ),
            ),
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
                    .doc(user_uid)
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

                                return _buildMessage(msg);
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
