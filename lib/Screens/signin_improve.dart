import 'dart:io';

import 'package:awesome_chat_app/Models/user_model.dart';
import 'package:awesome_chat_app/Widgets/signin/auth_stuff.dart';
import 'package:awesome_chat_app/Widgets/signin/myBlack.dart';
import 'package:awesome_chat_app/Widgets/signin/myChild.dart';
import 'package:awesome_chat_app/Widgets/signin/ui_signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:math' show pi;

class SignIn_Improve extends StatefulWidget {
  SignIn_Improve({Key key}) : super(key: key);

  @override
  _SignIn_ImproveState createState() => _SignIn_ImproveState();
}

class _SignIn_ImproveState extends State<SignIn_Improve>
    with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  User2 user;
//! this is submit auth form to firebase
  void _submitAuthForm(
      User2 user, bool isLogin, File image, BuildContext ctx) async {
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: user.email, password: user.password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: user.email, password: user.password);

        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(user.email + '.jpg');
        await ref.putFile(image).onComplete;
        final url = await ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .document(user.email)
            .setData({
          'name': user.name,
          'email': user.email,
          'uid': authResult.user.uid,
          'url': url
        });
        await FirebaseFirestore.instance
            .collection('users')
            .document(authResult.user.uid)
            .setData({
          'name': user.name,
          'email': user.email,
          'uid': authResult.user.uid,
          'url': url
        });
      }
    } on PlatformException catch (err) {
      var message = 'Error!';
      if (err.message != null) {
        message = err.message;
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      var message = 'Error!';
      if (err.message != null) {
        message = err.message;
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
      print(err);

      setState(() {
        _isLoading = false;
      });
    }
  }

  //! this is animation parameter
  AnimationController _animationController;
  final double MaxSlide = 1;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    toogle();
  }

  void toogle() => _animationController.forward();

  final _formKey = GlobalKey<FormState>();
  var myYellow = new Container(color: Color.fromRGBO(250, 230, 205, 1));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Material(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            double slide = MaxSlide * _animationController.value;
            double scalex = 1 - (_animationController.value * 0.5);
            double scaley = 1 - (_animationController.value * 0.75);

            double angel = _animationController.value * pi / 2;
            if (_animationController.value != 1) {
              return Stack(
                children: <Widget>[
                  myYellow,
                  //MyChild(),
                  Transform(
                      transform: Matrix4.identity()
                        //..translate(scaley, scaley)
                        ..scale(scalex, scaley),
                      alignment: Alignment(1, 0.8),
                      child: myBlack1(
                          key: UniqueKey(), par: _animationController.value)),
                ],
              );
            } else {
              return Stack(
                children: <Widget>[
                  myYellow,
                  Transform(
                      transform: Matrix4.identity()
                        //..translate(scaley, scaley)
                        ..scale(scalex, scaley),
                      alignment: Alignment(1, 0.8),
                      child: myBlack1(
                          key: UniqueKey(), par: _animationController.value)),
                  //! you need to pass _submitAuthForm (<--- this is a pointer not a function) to MyChild widget to get information from user
                  MyChild(_submitAuthForm, _isLoading),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
