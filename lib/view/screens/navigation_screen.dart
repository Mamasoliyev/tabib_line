import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabib_line/view_model/buttom_navigation_provider.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<ButtomNavigationProvider>(
      context,
      listen: true,
    );
    return Scaffold(
      bottomNavigationBar: Consumer<ButtomNavigationProvider>(
        builder: (context, value, child) => buildButtomNavigationBar(value),
      ),
      body: IndexedStack(
        children: [navigationProvider.screen[navigationProvider.index]],
      ),
    );
  }

  CurvedNavigationBar buildButtomNavigationBar(ButtomNavigationProvider value) {
    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      index: value.index,
      items: <Widget>[
        Icon(Icons.local_hospital_outlined, size: 35, color: Colors.black),
        Icon(Icons.home, size: 35, color: Colors.black),
        Icon(Icons.person, size: 35, color: Colors.black),
      ],

      height: 55,
      animationCurve: Curves.linearToEaseOut,
      onTap: (index) {
        value.setIndex(index);
      },
      backgroundColor: Theme.of(context).colorScheme.primary,
      color: Colors.blueAccent,
      buttonBackgroundColor: Colors.amber,
      maxWidth: double.infinity,
    );
  }
}
