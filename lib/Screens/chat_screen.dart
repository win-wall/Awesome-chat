import 'package:awesome_chat_app/Models/message_model.dart';
import 'package:awesome_chat_app/Screens/seach_screen.dart';
import 'package:awesome_chat_app/Widgets/main_chatScreen/CategorySection.dart';
import 'package:awesome_chat_app/Widgets/main_chatScreen/RecentChats.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            iconSize: 30,
            color: Colors.white,
          ),
          title: Text(
            'Chats',
            style: TextStyle(
              fontSize: 28,
            ),
          ),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              iconSize: 30,
              color: Colors.white,
              onPressed: () => {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => SearchScreen()))
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            CategorySection(),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                            MediaQuery.of(context).size.width * 0.1),
                        topRight: Radius.circular(
                            MediaQuery.of(context).size.width * 0.1))),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    RecentChats(),
                  ],
                ),
              ),
            )
          ],
        ));
    /*Scaffold(
        body: StreamBuilder(
          stream: Firestore.instance
              .collection('chats/Uamg3z5CW5OMSUTI5bRd/messages')
              .snapshots(),
          builder: (ctx, streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final documents = streamSnapshot.data.documents;
            return ListView.builder(
                itemCount: streamSnapshot.data.documents.length,
                itemBuilder: (ctx, index) => Container(
                    padding: EdgeInsets.all(8),
                    child: Text(documents[index]['text'])));
          },
        ),
        floatingActionButton:
            FloatingActionButton(child: Icon(Icons.add), onPressed: () {}));
  }*/
  }
}
