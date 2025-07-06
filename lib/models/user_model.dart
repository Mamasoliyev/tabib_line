class UserModel {
  final String uid;
  final String name;
  final String email;
  final String? phone;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.phone,
    required String id,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String docId) {
    return UserModel(
      uid: docId,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'],
      id: '',
    );
  }

  Map<String, dynamic> toMap() {
    return {"name": name, "email": email, if (phone != null) "phone": phone};
  }
}

extension UserModelCopy on UserModel {
  UserModel copyWith({String? name, String? phone}) {
    return UserModel(
      uid: uid,
      name: name ?? this.name,
      email: email,
      phone: phone ?? this.phone,
      id: '',
    );
  }
}
