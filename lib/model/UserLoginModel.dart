class UserLoginModel {
  String? uid;
  UserLoginModel({
    this.uid,
  });

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
