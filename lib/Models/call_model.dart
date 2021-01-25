class Call {
  String callerId;
  String callerName;
  String callerUrl;
  String receiverID;
  String receiverName;
  String receiverUrl;
  String receiverId;
  String channelId;
  bool hasDialled;
  Call(
      {this.callerId,
      this.callerName,
      this.callerUrl,
      this.receiverID,
      this.receiverName,
      this.receiverUrl,
      this.channelId,
      this.hasDialled});
  Map<String, dynamic> toMap(Call call) {
    Map<String, dynamic> callMap = Map();
    callMap['callerId'] = call.callerId;
    callMap['callerName'] = call.callerName;
    callMap['callerUrl'] = call.callerUrl;
    callMap['receiverID'] = call.receiverID;
    callMap['receiverName'] = call.receiverName;
    callMap['receiverUrl'] = call.receiverUrl;
    callMap['channelId'] = call.channelId;
    callMap['hasDialled'] = call.hasDialled;
  }

  Call.fromMap(Map callMap) {
    this.callerId = callMap['callerId'];
    this.callerName = callMap['callerName'];
    this.callerUrl = callMap['callerUrl'];
    this.receiverID = callMap['receiverID'];
    this.receiverName = callMap['receiverName'];
    this.receiverUrl = callMap['receiverUrl'];
    this.channelId = callMap['channelId'];
    this.hasDialled = callMap['hasDialled'];
  }
}
