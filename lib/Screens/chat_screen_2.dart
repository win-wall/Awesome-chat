import 'package:awesome_chat_app/Models/message_model.dart';
import 'package:awesome_chat_app/Models/user_model.dart';
import 'package:flutter/material.dart';

class ChatScreens extends StatefulWidget {
  final User user;

  ChatScreens({this.user});

  @override
  _ChatScreensState createState() => _ChatScreensState();
}

class _ChatScreensState extends State<ChatScreens> {
  _buildMessage(Message message, bool isMe) {
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
            message.time,
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
          )),
          IconButton(icon: Icon(Icons.send), onPressed: null)
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
              child: ClipRRect(
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
              ),
            ),
          ),
          _buildMessageComposer(),
        ]),
      ),
    );
  }
}
