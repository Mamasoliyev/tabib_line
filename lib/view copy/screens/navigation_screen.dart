import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tabib_line/view%20copy/screens/appointment_screen.dart';
import 'package:tabib_line/view%20copy/screens/home_screen.dart';
import 'package:tabib_line/view%20copy/screens/profile_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _page = 1;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  List<Widget> screen = [AppointmentScreen(), HomeScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildButtomNavigationBar(),
      body: screen[_page],
    );
  }

  CurvedNavigationBar buildButtomNavigationBar() {
    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      index: 1,
      items: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.local_hospital_outlined, color: Colors.black),
            Text(
              'Hospital',
              style: TextStyle(color: Colors.black, fontSize: 13),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home, color: Colors.black),
            Text('Home', style: TextStyle(color: Colors.black, fontSize: 16)),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, color: Colors.black),
            Text(
              'Profile',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ],

      height: 55,
      animationCurve: Curves.linearToEaseOut,
      onTap: (index) {
        setState(() {
          _page = index;
        });
      },
      backgroundColor: Colors.white,
      color: Colors.blue,
      buttonBackgroundColor: Colors.blue,
      maxWidth: double.infinity,
    );
  }
}
