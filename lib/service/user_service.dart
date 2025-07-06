import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tabib_line/models/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> getUser(String uid) async {
    try {
      final doc = await _firestore.collection("users").doc(uid).get();
      if (doc.exists && doc.data() != null) {
        return UserModel.fromMap(doc.data()!, doc.id);
      }
      return null;
    } catch (e) {
      print("GetUser error: $e");
      return null;
    }
  }

  Future<void> updateUser(String s, String trim, {
    required String uid,
    required String name,
    String? phone,
  }) async {
    try {
      final data = <String, dynamic>{'name': name};
      if (phone != null && phone.isNotEmpty) {
        data['phone'] = phone;
      }

      await _firestore.collection("users").doc(uid).update(data);
    } catch (e) {
      print("UpdateUser error: $e");
      rethrow;
    }
  }
}
