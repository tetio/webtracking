import 'dart:async';
import 'dart:convert';

import 'package:webtracking/domain/user-info.dart';
import 'package:http/http.dart' as http;

abstract class BaseAuth {
  Future<String> signIn(String email, String password);
  UserInfo getCurrentUser();
}

class Auth implements BaseAuth {
  UserInfo userInfo;

  Future<String> signIn(String username, String password) async {
    final response = await http.post(
        'http://montjuic.portic.net/webtracking/services/rest/login',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{'username': username, 'password': password}));
    if (response.statusCode == 200) {
      userInfo = UserInfo.fromJson(json.decode(response.body));
      return userInfo.token;
    } else {
      throw Exception('Failed to sign in');
    }
  }

  UserInfo getCurrentUser() {
    return userInfo;
  }
}
