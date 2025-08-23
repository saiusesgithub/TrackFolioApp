import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(161, 255, 206, 1.0).withValues(alpha: 0.7),
            Color.fromRGBO(250, 255, 209, 1.0).withValues(alpha: 0.7),
          ],
        ),
      ),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 175,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
          ),
          title: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [_appBarTitle(), SizedBox(height: 30), _appBarGreeting()],
          ),
          flexibleSpace: ClipPath(
            clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(25),
                ),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(161, 255, 206, 1.0).withValues(alpha: 1.0),
                    Color.fromRGBO(250, 255, 209, 1.0).withValues(alpha: 1.0),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: _bottomNavBar(),
        floatingActionButton: _addBookButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Widget _bottomNavBar() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(161, 255, 206, 1.0).withAlpha(200),
              Color.fromRGBO(250, 255, 209, 1.0).withAlpha(200),
            ],
          ),
        ),
        child: SizedBox(
          height: 65,
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedHome01,
                  color: Colors.black,
                ),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedPieChart,
                  color: Colors.black,
                ),
                label: 'stats',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _addBookButton() {
    return FloatingActionButton(
      child: HugeIcon(
        icon: HugeIcons.strokeRoundedBookUpload,
        color: Colors.black,
      ),
      onPressed: () {},
    );
  }

  Widget _appBarTitle() {
    return Text(
      'Trackfolio',
      style: TextStyle(
        color: Colors.black,
        fontSize: 32,
        fontFamily: 'EduCursive',
      ),
    );
  }

  Widget _appBarGreeting() {
    DateTime _dt = DateTime.now();
    String? greetingText;
    String _userName = "Sai";

    if (_dt.hour < 12 && _dt.hour > 6) {
      greetingText = "Good Morning";
    } else if (_dt.hour < 16) {
      greetingText = "Good Afternoon";
    } else if (_dt.hour < 20) {
      greetingText = "Good Evening";
    } else {
      greetingText = "Good Night";
    }

    return Text(
      '$greetingText $_userName',
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
