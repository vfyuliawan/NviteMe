class UserLoginModel {
  String? uid;
  String? displayName;
  UserLoginModel({this.uid, this.displayName});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
    };
  }

  factory UserLoginModel.fromMap(Map<String, dynamic> map) {
    return UserLoginModel(
      uid: map['uid'] as String,
    );
  }
}
