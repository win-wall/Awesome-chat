import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FirebaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser currentUser;
    currentUser = await _auth.currentUser;
    return currentUser;
  }

  Future<FirebaseUser> signIn() async {}
}
