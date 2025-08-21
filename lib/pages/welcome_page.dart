import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});
  double? _deviceHeight, _deviceWidth;

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
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromRGBO(161, 255, 206, 1.0),
              Color.fromRGBO(250, 255, 209, 1.0),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_titleWidgets(), _quote(), _buttons(context)],
        ),
      ),
    );
  }

  Widget _titleWidgets() {
    return Column(
      children: [
        Text(
          "TrackFolio",
          style: TextStyle(
            color: Colors.black,
            fontSize: 45,
            fontFamily: 'EduCursive',
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 5),
        Text("Your Reading, Organized."),
      ],
    );
  }

  Widget _quote() {
    return Text(
      "What gets measured, gets improved. \n                                                   - Peter Drucker",
    );
  }

  Widget _buttons(BuildContext context) {
    return Column(
      children: [
        _registerButton(context),
        SizedBox(height: 15),
        _loginButton(context),
      ],
    );
  }

  Widget _registerButton(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: OutlinedButton(
        style: ButtonStyle(
          side: WidgetStateProperty.all(
            BorderSide(color: Colors.black, width: 1),
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, 'register');
        },
        child: Text(
          "Register",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: OutlinedButton(
        style: ButtonStyle(
          side: WidgetStateProperty.all(
            BorderSide(color: Colors.black, width: 1),
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, 'login');
        },
        child: Text(
          "Login",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
