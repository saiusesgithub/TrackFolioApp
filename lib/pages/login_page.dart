import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:trackfolio/services/firebase_auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double? _deviceHeight, _deviceWidth;
  String? email, password;
  FirebaseAuthService _firebaseAuthService = GetIt.instance
      .get<FirebaseAuthService>();

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: _deviceHeight,
        width: _deviceWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(161, 255, 206, 1.0),
              Color.fromRGBO(250, 255, 209, 1.0),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [_title(), _forms(), _button()],
        ),
      ),
    );
  }

  Widget _title() {
    return Container(
      child: Text(
        "Login",
        style: TextStyle(
          color: Colors.black,
          fontSize: 35,
          fontFamily: 'EduCursive',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _forms() {
    return Form(
      key: _formKey,
      child: Column(children: [_emailFormField(), _passwordFormField()]),
    );
  }

  Widget _button() {
    return Column(children: [_loginButton()]);
  }

  Widget _emailFormField() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        onSaved: (newValue) {
          email = newValue;
        },
        validator: (value) {
          bool _result = value!.contains(
            RegExp(
              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
            ),
          );
          return _result ? null : "Please enter a registered email.";
        },
        decoration: InputDecoration(
          hintText: "Email...",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _passwordFormField() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        onSaved: (newValue) {
          password = newValue;
        },
        validator: (value) {
          if (value!.length < 6) {
            return "Please enter the correct password.";
          }
          return null;
        },
        obscureText: true,
        decoration: InputDecoration(
          hintText: "Password...",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: OutlinedButton(
        style: ButtonStyle(
          side: WidgetStateProperty.all(
            BorderSide(color: Colors.black, width: 1),
          ),
        ),
        onPressed: _loginUser,
        child: Text("Login"),
      ),
    );
  }

  void _loginUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      bool _result = await _firebaseAuthService.loginUser(
        email: email!,
        password: password!,
      );
      if (_result) {
        Navigator.popAndPushNamed(context, 'home');
      }
    }
  }
}
