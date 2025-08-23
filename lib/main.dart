import 'package:flutter/material.dart';
import 'package:trackfolio/pages/login_page.dart';
import 'package:trackfolio/pages/register_page.dart';
import 'package:trackfolio/pages/splash_screen.dart';
import 'package:trackfolio/pages/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrackFolio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.tealAccent),
        fontFamily: 'Nunito',
      ),
      routes: {
        'splash': (context) => SplashScreen(),
        'welcome': (context) => WelcomePage(),
        'register': (context) => RegisterPage(),
        'login': (context) => LoginPage(),
      },
      initialRoute: 'splash',
    );
  }
}
