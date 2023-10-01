import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifafu/http/model.dart';
import 'package:ifafu/util/sp.dart';

class UserProvider extends Cubit<User?> {
  UserProvider() : super(_loadUserFromSP());

  static User? _loadUserFromSP() {
    final jsonString = SPUtil.getString('USER');
    if (jsonString != null) {
      final userMap = json.decode(jsonString);
      return User.fromJson(userMap);
    }
    return null;
  }

  bool isLogin() {
    return state != null;
  }

  void update(User? user) {
    if (user == null) {
      logout();
      return;
    } else if (user != state) {
      print('### update user: $user');
      emit(user);
      SPUtil.setString('USER', json.encode(user.toJson()));
    }
  }

  void logout() {
    emit(null);
    SPUtil.remove('USER');
    SPUtil.remove('TOKEN');
  }
}
