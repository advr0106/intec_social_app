class UserModel {
  final String uid;
  final String username;
  final String email;
  final String? profilePic;
  final String? bio;
  final String? phone;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    this.profilePic,
    this.bio,
    this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'profilePic': profilePic,
      'bio': bio,
      'phone': phone,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      username: map['username'],
      email: map['email'],
      profilePic: map['profilePic'],
      bio: map['bio'],
      phone: map['phone'],
    );
  }
}
