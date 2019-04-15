import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class UserRepository {

  SharedPreferences _preferences;
  final String lastToken = "lastToken";

  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    return "token";
  }

  Future<void> deleteToken() async {
    _preferences = await SharedPreferences.getInstance();
    _preferences.setString(lastToken, "");
    return;
  }

  Future<void> persistToken(String token) async {
    _preferences = await SharedPreferences.getInstance();
    _preferences.setString(lastToken, (token != null && token.length > 0) ? token : "");
    return;
  }

  Future<bool> hasToken() async {
    _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString(lastToken);
    if(token!=null && token!= "" && token.length > 0) {
      return true;
    } else {
      return false;
    }
  }

}