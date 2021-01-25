class User {
  final int id;
  final String name;
  final String imageUrl;

  User({
    this.id,
    this.name,
    this.imageUrl,
  });
}

class User2 {
  String uid;
  String name;
  String email;
  String password;
  String status;
  String url;
  int state;
  User2(
      {this.uid,
      this.name,
      this.email,
      this.password,
      this.status,
      this.url,
      this.state});
  Map toMap(User2 user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['name'] = user.name;
    data['email'] = user.email;
    data['password'] = user.password;
    data['status'] = user.status;
    data['url'] = user.url;
    data['state'] = user.state;
    return data;
  }

  User2.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.name = mapData['name'];
    this.email = mapData['email'];
    this.password = mapData['password'];
    this.status = mapData['status'];
    this.url = mapData['url'];
    this.state = mapData['state'];
  }
}
