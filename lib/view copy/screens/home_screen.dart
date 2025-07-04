import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   @override
  @override
  Widget build(BuildContext context) {
  return Scaffold(
        backgroundColor: Colors.white,
         body:  Center( child: Text('HomeScreen', style: TextStyle(color: Colors.black),),));

  }
}
