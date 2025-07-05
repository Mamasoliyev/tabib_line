import 'package:flutter/material.dart';
import 'package:tabib_line/view/screens/appointment_screen.dart';
import 'package:tabib_line/view/screens/home_screen.dart';
import 'package:tabib_line/view/screens/profile_screen.dart';

class ButtomNavigationProvider extends ChangeNotifier {
  int index = 0;
  List<Widget> screen = [
    AppointmentScreen(),
    HomeScreen(),
    ProfileScreen(),
  ];

  void setIndex(int newIndex) {
    index = newIndex;
    notifyListeners();
  }
}
