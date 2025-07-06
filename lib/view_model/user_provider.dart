import 'package:flutter/material.dart';
import 'package:tabib_line/models/user_model.dart';
import 'package:tabib_line/service/user_service.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();

  UserModel? _user;
  bool _isLoading = false;
  String _errorMessage = "";

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchUser(String uid) async {
    _isLoading = true;
    _errorMessage = "";

    try {
      final fetchedUser = await _userService.getUser(uid);
      if (fetchedUser != null) {
        _user = fetchedUser;
      } else {
        _errorMessage = "User not found";
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUser({
    required String uid,
    required String name,
    String? phone,
  }) async {
    _isLoading = true;
    _errorMessage = "";
    notifyListeners();

    try {
      await _userService.updateUser("", "", uid: uid, name: name, phone: phone);

      _user = UserModel(
        id: uid,
        name: name,
        email: _user?.email ?? "",
        phone: phone ?? _user?.phone ?? "", uid: '',
      );
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
