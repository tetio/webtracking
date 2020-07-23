import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:webtracking/domain/user-info.dart';
import 'package:http/http.dart' as http;

abstract class BaseAuth {
  Future<String> signIn(String email, String password);

  UserInfo getCurrentUser();
}

class Auth implements BaseAuth {
  UserInfo _userInfo;

  Future<String> signIn(String username, String password) async {
    final response = await http.post(
        'http://montjuic.portic.net/webtracking/services/rest/login',
        body: "{\"username\": $username, \"password\": $password}");
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      _userInfo = UserInfo.fromJson(json.decode(response.body));
      return _userInfo.token;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to sign in');
    }
  }

  UserInfo getCurrentUser() {
    return _userInfo;
  }
}
