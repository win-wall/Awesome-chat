import 'package:awesome_chat_app/Models/message_model.dart';
import 'package:awesome_chat_app/Screens/chat_screen.dart';
import 'package:awesome_chat_app/Screens/chat_screen_2.dart';
import 'package:flutter/material.dart';

class RecentChats extends StatefulWidget {
  RecentChats({Key key}) : super(key: key);

  @override
  _RecentChatsState createState() => _RecentChatsState();
}

class _RecentChatsState extends State<RecentChats> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft:
                    Radius.circular(MediaQuery.of(context).size.width * 0.1),
                topRight:
                    Radius.circular(MediaQuery.of(context).size.width * 0.1))),
        child: ListView.builder(
          itemCount: chats.length,
          itemBuilder: (BuildContext ctx, int index) {
            final Message chat = chats[index];
            return GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ChatScreens(
                            user: chat.sender,
                          ))),
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
      ),
    );
  }
}
