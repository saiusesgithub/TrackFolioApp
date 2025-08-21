import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double? _deviceHeight, _deviceWidth;
  String? name, email, password;

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
        child: Column(children: [_title(), _forms()]),
      ),
    );
  }

  Widget _title() {
    return Container(
      child: Text(
        "Register",
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
      child: Column(
        children: [
          _NameFormField(),
          _emailFormField(),
          _passwordFormField(),
          _registerButton(),
        ],
      ),
    );
  }

  Widget _NameFormField() {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: TextFormField(
        onSaved: (newValue) {
          name = newValue;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return "please enter a valid name";
          }
          return null;
        },
        decoration: InputDecoration(hintText: "Name..."),
      ),
    );
  }

  Widget _emailFormField() {
    return Padding(
      padding: const EdgeInsets.all(50.0),
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
          return _result ? null : "Please enter a valid email";
        },
        decoration: InputDecoration(hintText: "Email..."),
      ),
    );
  }

  Widget _passwordFormField() {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: TextFormField(
        onSaved: (newValue) {
          password = newValue;
        },
        validator: (value) {
          if (value!.length < 6) {
            return "password should atleast be 6 characters";
          }
          return null;
        },
        obscureText: true,
        decoration: InputDecoration(hintText: "Password..."),
      ),
    );
  }

  Widget _registerButton() {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: OutlinedButton(
        style: ButtonStyle(
          side: WidgetStateProperty.all(
            BorderSide(color: Colors.black, width: 1),
          ),
        ),
        onPressed: _registerUser,
        child: Text("Register"),
      ),
    );
  }

  void _registerUser() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }
}
