import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_chat_app/Models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'user_image_picker.dart';

class MyChild extends StatefulWidget {
  //! this is place where we create contructor to get all information from Mychild to signin_improve
  MyChild(this.submitFn, this.isLoading);
  final bool isLoading;
  final void Function(User2 user, bool isLogin, File image, BuildContext ctx)
      submitFn;
  @override
  _MyChildState createState() => _MyChildState();
}

class _MyChildState extends State<MyChild> {
  final _formKey = GlobalKey<FormState>();
  User2 user = new User2();
  bool _isLogin = true;
  String _userEmail = '';
  String _userPassword = '';
  String _userName = '';
  File _userImageFile;
  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (_userImageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please pick an image'),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }
    if (isValid) {
      //! This will trigger TextFormField to save the information
      _formKey.currentState.save();
      //! This will save all information from Form widget bellow, to submitFn contructor above, and pointer from signin_improve can get
      //! information to submit it into firebase
      widget.submitFn(user, _isLogin, _userImageFile, context);
      FirebaseAuth.instance.authStateChanges().listen((firebaseUser) {
        if (firebaseUser != null) Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //! use Scaffpld to remove yellow underline and scroll able in Text widget - Tuong
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 0, 0),
      body: Material(
        type: MaterialType.transparency,
        child: SingleChildScrollView(
          child: Container(
            //color: Color.fromRGBO(250, 230, 205, 1),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Container(
              alignment: Alignment(0.3, 0),
              child: Container(
                //color: Color.fromRGBO(0, 0, 0, 1),
                height: MediaQuery.of(context).size.height * 0.9016,
                width: MediaQuery.of(context).size.width * 0.8352,
                child: Stack(
                  children: <Widget>[
                    //! this is container contain Hello
                    Container(
                      alignment:
                          _isLogin ? Alignment(-1, -0.7) : Alignment(-1, -0.8),
                      child: Container(
                        child: AutoSizeText(
                          _isLogin
                              ? 'Hello there,\nWelcome back!'
                              : 'Hello new friend,\nLet create an account',
                          style: TextStyle(
                              fontSize: 100,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Time new roman'),
                          maxLines: 2,
                        ),
                        height: MediaQuery.of(context).size.height * 0.11,
                        width: MediaQuery.of(context).size.width * 0.65,
                      ),
                    ),
                    //! this is container contain Form
                    Container(
                      alignment:
                          _isLogin ? Alignment(0.3, 0.6) : Alignment(0.3, -0.1),
                      child: SingleChildScrollView(
                        child: Container(
                          //color: Colors.black,
                          child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  if (!_isLogin) UserImagePicker(_pickedImage),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    child: TextFormField(
                                      key: ValueKey('email'),
                                      validator: (value) {
                                        if (value.isEmpty ||
                                            !value.contains('@')) {
                                          return 'Please enter a valid email address';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          labelText: 'Your Email'),
                                      onSaved: (value) {
                                        user.email = value.trim();
                                      },
                                    ),
                                  ),
                                  if (_isLogin)
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                  if (!_isLogin)
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: TextFormField(
                                        key: ValueKey('name'),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'I think you have a name';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            labelText: 'Full Name'),
                                        onSaved: (value) {
                                          user.name = value.trim();
                                        },
                                      ),
                                    ),
                                  if (_isLogin)
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    child: TextFormField(
                                      key: ValueKey('password'),
                                      validator: (value) {
                                        if (value.isEmpty || value.length < 6) {
                                          return 'Please enter at least 6 characters';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          labelText: 'Password'),
                                      obscureText: true,
                                      onSaved: (value) {
                                        user.password = value;
                                      },
                                    ),
                                  ),
                                ],
                              )),
                          height: _isLogin
                              ? MediaQuery.of(context).size.height * 0.5082
                              : MediaQuery.of(context).size.height * 0.45,
                          width: MediaQuery.of(context).size.width * 0.9108,
                        ),
                      ),
                    ),
                    //! this is container contain sign in and flatbutton
                    Container(
                      alignment: Alignment(0.3, 0.7),
                      child: Container(
                        //color: Colors.black,
                        child: Stack(
                          children: <Widget>[
                            //! this is container for Sign in/Sign up AutosizeWidget
                            Container(
                              alignment: Alignment(-1, 0),
                              child: Container(
                                //color: Colors.black,
                                child: AutoSizeText(
                                  _isLogin ? 'Sign in' : 'Sign up',
                                  style: TextStyle(
                                      fontSize: 100,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Time new roman'),
                                  maxLines: 1,
                                ),
                                width: MediaQuery.of(context).size.width * 0.35,
                              ),
                            ),
                            //! this is container for flatbutton Arrow Right
                            Container(
                                alignment: Alignment(0.85, 0),
                                child: Container(
                                    //color: Colors.black,
                                    child: widget.isLoading
                                        //! when submit to login signup will show wait circul
                                        ? Container(
                                            alignment: Alignment(0.6, 0),
                                            child: CircularProgressIndicator(
                                              strokeWidth: 5.0,
                                            ),
                                          )
                                        : FlatButton(
                                            //! _trySubmit fuction
                                            onPressed: _trySubmit,
                                            child: Icon(
                                                Icons
                                                    .keyboard_arrow_right_outlined,
                                                color: Colors.white,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.1),
                                          )))
                          ],
                        ),
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                    ),
                    //! this is container contain text widget for sign up
                    Container(
                        alignment: Alignment(-1, 0.93),
                        child: Container(
                            //color: Colors.black,
                            child: RichText(
                                text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: _isLogin ? 'Not got an account? ' : '',
                              style: TextStyle(
                                color: Colors.grey,
                              )),
                          TextSpan(
                              text: _isLogin ? 'Sign up' : 'Sign in',
                              style: TextStyle(
                                  color: Color.fromRGBO(60, 59, 45, 1),
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  setState(() {
                                    _isLogin = !_isLogin;
                                  });
                                })
                        ]))))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
