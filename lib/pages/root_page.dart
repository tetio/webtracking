import 'package:flutter/material.dart';
import 'package:webtracking/domain/user-info.dart';
import 'package:webtracking/pages/home_page.dart';
import 'package:webtracking/pages/login_signup_page.dart';
import 'package:webtracking/services/authentication.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class RootPage extends StatefulWidget {
  RootPage(this.auth);

  final Auth auth;

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  UserInfo _userInfo;

  @override
  void initState() {
    super.initState();
    UserInfo userInfo = widget.auth.getCurrentUser();
    setState(() {
      if (userInfo != null) {
        _userInfo = userInfo;
      }
      authStatus = _userInfo?.userLogado == null
          ? AuthStatus.NOT_LOGGED_IN
          : AuthStatus.LOGGED_IN;
    });
  }

  void loginCallback() {
    UserInfo userInfo = widget.auth.getCurrentUser();
    if (userInfo != null) {
      setState(() {
        _userInfo = userInfo;
        authStatus = AuthStatus.LOGGED_IN;
      });
    }
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userInfo = null;
    });
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return LoginSignupPage(
          auth: widget.auth,
          loginCallback: loginCallback,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userInfo != null &&
            _userInfo.userLogado != null &&
            _userInfo.userLogado.length > 0) {
          return HomePage(
            username: _userInfo.userLogado,
            auth: widget.auth,
            logoutCallback: logoutCallback,
          );
        } else
          return buildWaitingScreen();
        break;
      default:
        return buildWaitingScreen();
    }
  }
}
