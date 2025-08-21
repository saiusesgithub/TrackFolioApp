import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  double? _deviceHeight, _deviceWidth;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushNamed(context, 'welcome');
    });
  }

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
          children: [_titleWidgets(), _quote()],
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
}
