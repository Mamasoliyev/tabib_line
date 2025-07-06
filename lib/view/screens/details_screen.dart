import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tabib_line/view/widgets/doctor_infos.dart';

class DetailScreen extends StatefulWidget {
  final String specialty;

  DetailScreen({super.key, required this.specialty});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<Map<String, dynamic>> doctors = [];

  @override
  void initState() {
    super.initState();
    loadDoctors();
  }

  Future<void> loadDoctors() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Doctors')
          .where('position', isEqualTo: widget.specialty)
          .get();

      print('Fetched ${snapshot.docs.length} doctors');

      for (var doc in snapshot.docs) {
        print(doc.data());
      }

      setState(() {
        doctors = snapshot.docs.map((doc) => doc.data()).toList();
      });
    } catch (e) {
      print('Error loading doctors: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.specialty} Shifokorlar')),
      body: doctors.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: doctors.map((doctor) {
                return DoctorInfos(doctor: doctor, width: double.infinity);
              }).toList(),
            ),
    );
  }
}
