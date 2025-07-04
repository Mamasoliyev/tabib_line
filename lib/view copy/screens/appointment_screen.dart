import 'package:flutter/material.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
        backgroundColor: Colors.white,
         body:  Center( child: Text('AppointmentScreen', style: TextStyle(color: Colors.black),),));

  }
}