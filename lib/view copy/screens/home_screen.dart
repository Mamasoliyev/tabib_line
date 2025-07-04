import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          items: <Widget>[
            Icon(Icons.add, size: 30, color: Colors.white,),
            Icon(Icons.list, size: 30, color: Colors.white,),
            Icon(Icons.menu, size: 30, color: Colors.white,),

            Icon(Icons.compare_arrows, size: 30, color: Colors.white,),
            Icon(Icons.compare_arrows, size: 30, color: Colors.white,),
            Icon(Icons.compare_arrows, size: 30, color: Colors.white,),

          ],
          height: 55,
          animationCurve: Curves.linearToEaseOut,
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          backgroundColor: Colors.blueAccent,
          color: Colors.black,
          buttonBackgroundColor: Colors.amber,
          maxWidth: double.infinity,
          
        ),
        body: Container(
          color: Colors.blueAccent,
          child: Center(
            child: Column(
              children: <Widget>[
                Text(_page.toString(), textScaleFactor: 10.0),
                ElevatedButton(
                  child: Text('Go To Page of index 1'),
                  onPressed: () {
                    //Page change using state does the same as clicking index 1 navigation button
                    final CurvedNavigationBarState? navBarState =
                        _bottomNavigationKey.currentState;
                    navBarState?.setPage(1);
                  },
                )
              ],
            ),
          ),
        ));
  }
}