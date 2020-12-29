import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Auth_stuff extends StatefulWidget {
  Auth_stuff(this.submitFn);
  final void Function(String email, String password, bool isLogin) submitFn;
  @override
  _Auth_stuffState createState() => _Auth_stuffState();
}

class _Auth_stuffState extends State<Auth_stuff> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userPassword = '';
  bool _isLogin = true;
  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(_userEmail, _userPassword, _isLogin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        hintStyle: TextStyle(color: Colors.black12)),
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty || value.length < 7) {
                          return 'Password must be at least 7 ducking character long.';
                        }
                        return null;
                      },
                      //!this thing hide your text
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          hintStyle: TextStyle(color: Colors.black12)),
                      onSaved: (value) {
                        _userPassword = value;
                      },
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      child: Text('Sign in', style: TextStyle(fontSize: 40)),
                    )),
                Expanded(
                    child: Container(
                        width: 150,
                        height: 100,
                        child: new RawMaterialButton(
                          onPressed: _trySubmit,
                          shape: new CircleBorder(),
                          elevation: 10.0,
                          fillColor: Colors.black,
                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.white,
                          ),
                        )))
              ],
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: Row(children: [
              Expanded(
                child: RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                      TextSpan(
                          text: _isLogin ? 'Sign up' : 'Sign in',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 20),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            })
                    ])),
              ),
              Expanded(
                flex: 0,
                child: RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                      TextSpan(
                          text: 'Forgot Password',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 20),
                          recognizer: TapGestureRecognizer()..onTap = () {})
                    ])),
              )
            ]),
          )
        ],
      ),
    ));
  }
}
