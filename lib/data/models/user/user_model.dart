class UserModel {
  String? uid;
  String? name;
  String? phone;
  String? email;
  String? password;

  UserModel({this.uid,this.name, this.phone, this.email,this.password});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      name:map['name'],
      phone: map['phone'],
      email: map['email'],
      password: map['password'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name':name,
      'phone':phone,
      'email': email,
      'password':password,
    };
  }
}
