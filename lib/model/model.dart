class UserModel {
  String? uid;
  String? email;
  String? fisrtname;
  String? secondname;

  UserModel({this.uid, this.email, this.fisrtname, this.secondname});

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      fisrtname: map['firstname'],
      secondname: map['secondname'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstname': fisrtname,
      'secondname': secondname,
    };
  }
}
