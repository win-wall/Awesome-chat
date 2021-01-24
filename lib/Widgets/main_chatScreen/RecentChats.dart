import 'package:awesome_chat_app/Models/message_model.dart';
import 'package:awesome_chat_app/Models/user_model.dart';
import 'package:awesome_chat_app/Screens/chat_screen.dart';
import 'package:awesome_chat_app/Screens/chat_screen_2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecentChats extends StatefulWidget {
  RecentChats({Key key}) : super(key: key);

  @override
  _RecentChatsState createState() => _RecentChatsState();
}

class _RecentChatsState extends State<RecentChats> {
  User2 user;
  String current_uid;
  Message2 msg;
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool yes;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                        MediaQuery.of(context).size.width * 0.1),
                    topRight: Radius.circular(
                        MediaQuery.of(context).size.width * 0.1))),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('chats/${auth.currentUser.uid}/messages')
                    .snapshots(),
                builder: (ctx, streamSnapshot) {
                  if (streamSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final documents = streamSnapshot.data.documents;

                  bool date_not = false;
                  return ListView.builder(
                      itemCount: streamSnapshot.data.documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        String text = documents[index]['text'];
                        String sender = documents[index]['sender'];
                        String receiver = documents[index]['receiver'];
                        String receiverName = documents[index]['receiverName'];
                        String senderName = documents[index]['senderName'];
                        Timestamp time = documents[index]['time'];
                        bool isMe = documents[index]['isMe'];
                        DateTime now = DateTime.now();
                        int date = int.parse(DateFormat('dd').format(now));
                        int date2 =
                            int.parse(DateFormat('dd').format(time.toDate()));
                        if (date > date2) {
                          date_not = true;
                        }
                        if (receiver == auth.currentUser.uid) {
                          print(receiverName);
                          yes = true;
                        } else {
                          print(receiverName);
                          yes = false;
                        }

                        if (sender == auth.currentUser.uid) {
                          msg = new Message2(
                              text: text,
                              sender: sender,
                              receiver: receiver,
                              time: time,
                              isMe: isMe);
                        } else {
                          msg = new Message2(
                              text: text,
                              sender: sender,
                              receiver: receiver,
                              time: time,
                              isMe: isMe);
                        }
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ChatScreens(
                                        current_uid: auth.currentUser.uid,
                                        user_uid: yes ? receiver : sender,
                                        username:
                                            yes ? receiverName : senderName,
                                      ))),
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 5.0, bottom: 5.0, right: 5.0, left: 5.0),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(
                                        MediaQuery.of(context).size.width *
                                            0.1),
                                    bottomRight: Radius.circular(
                                        MediaQuery.of(context).size.width *
                                            0.1),
                                    topLeft: Radius.circular(
                                        MediaQuery.of(context).size.width *
                                            0.1),
                                    bottomLeft: Radius.circular(
                                        MediaQuery.of(context).size.width *
                                            0.1))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 35,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          yes != null
                                              ? senderName
                                              : receiverName,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.45,
                                          child: Text(
                                            msg.text,
                                            style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(date_not
                                        ? DateFormat('yyyy-MM-dd')
                                            .format(msg.time.toDate())
                                        : DateFormat.Hms()
                                            .format(msg.time.toDate())),
                                    Text('new')
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      });
                })));
  }
}
/* ListView.builder(
          itemCount: chats.length,
          itemBuilder: (BuildContext ctx, int index) {
            final Message chat = chats[index];
            return GestureDetector(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ChatScreens())),
              child: Container(
                margin: EdgeInsets.only(
                    top: 5.0, bottom: 5.0, right: 5.0, left: 5.0),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: chat.unread ? Color(0xFFFFEEEE) : Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(
                            MediaQuery.of(context).size.width * 0.1),
                        bottomRight: Radius.circular(
                            MediaQuery.of(context).size.width * 0.1),
                        topLeft: Radius.circular(
                            MediaQuery.of(context).size.width * 0.1),
                        bottomLeft: Radius.circular(
                            MediaQuery.of(context).size.width * 0.1))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage(chat.sender.imageUrl),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              chat.sender.name,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Text(
                                chat.text,
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [Text(chat.time), Text('new')],
                    )
                  ],
                ),
              ),
            );
          },
        ),
  }
}*/
