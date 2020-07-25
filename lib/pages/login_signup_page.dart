import 'package:flutter/material.dart';
import 'package:webtracking/services/authentication.dart';

class LoginSignupPage extends StatefulWidget {
  LoginSignupPage({this.auth, this.loginCallback});

  final Auth auth;
  final VoidCallback loginCallback;

  @override
  _LoginSignupPageState createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final _formKey = new GlobalKey<FormState>();
  String _username;
  String _password;
  bool _isLoading = false;
  bool _isLoginForm = true;
  String _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('WebTracking login'),
        ),
        body: Stack(
          children: <Widget>[
            showForm(),
            showCircularProgress(),
          ],
        ));
  }

  Widget showForm() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            showLogo(),
            showUsernameInput(),
            showPasswordInput(),
            showPrimaryButton(),
            // showSecondaryButton(),
            showErrorMessage(),
          ],
        ),
      ),
    );
  }

  Widget showCircularProgress() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget showLogo() {
    return Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          child: Image.asset('assets/images/logo-portic.png'),
        ),
      ),
    );
  }

  Widget showUsernameInput() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
        child: TextFormField(
          maxLines: 1,
          keyboardType: TextInputType.text,
          autofocus: false,
          decoration: InputDecoration(
            hintText: 'Username',
            icon: Icon(
              Icons.account_box,
              color: Colors.grey,
            ),
          ),
          validator: (value) => value.isEmpty ? 'Username is empty' : null,
          onSaved: (value) => _username = value.trim(),
        ));
  }

  Widget showPasswordInput() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
        child: TextFormField(
          maxLines: 1,
          obscureText: true,
          autofocus: false,
          decoration: InputDecoration(
              hintText: 'Password',
              icon: Icon(
                Icons.lock,
                color: Colors.grey,
              )),
          validator: (value) =>
              value.isEmpty ? 'Password can\'t be empty' : null,
          onSaved: (value) => _password = value.trim(),
        ));
  }

  Widget showPrimaryButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: SizedBox(
        height: 40.0,
        child: RaisedButton(
          onPressed: () => validateAndSubmit(),
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Colors.blue,
          child: Text(
            _isLoginForm ? 'Login' : 'Create Account',
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget showErrorMessage() {
    if (_errorMessage != null && _errorMessage.length > 0) {
      return Text(
        _errorMessage,
        style: TextStyle(
          fontSize: 13.9,
          color: Colors.red,
          height: 1.0,
          fontWeight: FontWeight.w300,
        ),
      );
    } else {
      return Container(
        height: 0.0,
      );
    }
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });

    if (validateAndSave()) {
      String token;
      try {
        if (_isLoginForm) {
          token = await widget.auth.signIn(_username, _password);
        }
        // else {
        //   userInfo = await widget.auth.signup(_username, _password);
        // }
        setState(() {
          _isLoading = false;
        });

        if (token != null && token.length > 0 && _isLoginForm) {
          widget.loginCallback();
        }
      } catch (e) {
        print('Error $e');
        setState(() {
          _isLoading = false;
        });
        _errorMessage = e.message;
        _formKey.currentState.reset();
      }
    }
  }
}
