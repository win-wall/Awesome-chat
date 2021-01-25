import 'package:awesome_chat_app/Models/call_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CallMethods {
  final CollectionReference callCollection =
      FirebaseFirestore.instance.collection('call');
  Future<bool> makeCall({Call call}) async {
    try {
      call.hasDialled = true;
      Map<String, dynamic> hasDialledMap = call.toMap(call);
      call.hasDialled = false;
      Map<String, dynamic> hasNotDialledMap = call.toMap(call);
      callCollection.doc(call.callerId).set(hasDialledMap);
      callCollection.doc(call.receiverID).set(hasNotDialledMap);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> endCall({Call call}) async {
    try {
      await callCollection.doc(call.callerId).delete();
      await callCollection.doc(call.receiverID).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
