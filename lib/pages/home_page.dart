import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
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
          title: Text(
            'Trackfolio',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontFamily: 'EduCursive',
            ),
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
}
