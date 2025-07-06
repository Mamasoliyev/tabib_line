import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tabib_line/utils/sizeBox.dart';
import 'package:tabib_line/view/widgets/category_item_widget.dart';
import 'package:tabib_line/view/widgets/doctor_infos.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> topDoctors = [];

  @override
  void initState() {
    super.initState();
    loadTopDoctors();
  }

  Future<void> loadTopDoctors() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Doctors')
        .orderBy('rating', descending: true)
        .limit(2)
        .get();

    setState(() {
      topDoctors = snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Row(
                children: const [
                  Icon(Icons.location_on, color: Colors.blue),

                  Text(
                    "Uzbekiston",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              25.h,

              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.green[100],
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://cdn.doctoranytime.gr/practices/b4da25df-d298-4b10-8627-e5664a7d2184.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(16),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Looking for \nSpecialist Doctors?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "\nSchedule an appointment with our top doctors.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              24.h,
              Text(
                "Categories",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              12.h,

              Wrap(
                spacing: 15,
                runSpacing: 15,
                children: [
                  categoryItem(
                    Icons.medical_services,
                    "Dentistry",
                    Colors.pink[100]!,
                    context,
                  ),
                  categoryItem(
                    Icons.favorite,
                    "Cardiology",
                    Colors.green[100]!,
                    context,
                  ),
                  categoryItem(
                    Icons.air,
                    "Pulmonology",
                    Colors.orange[100]!,
                    context,
                  ),
                  categoryItem(
                    Icons.home_work_sharp,
                    "Terapevty",
                    Colors.purple[100]!,
                    context,
                  ),
                  categoryItem(
                    Icons.psychology,
                    "Neurology",
                    Colors.teal[100]!,
                    context,
                  ),
                  categoryItem(
                    Icons.local_hospital,
                    "Gastroen..",
                    Colors.deepPurple[100]!,
                    context,
                  ),
                  categoryItem(
                    Icons.science,
                    "Laboratory",
                    Colors.red[100]!,
                    context,
                  ),
                  categoryItem(
                    Icons.vaccines,
                    "Vaccination",
                    Colors.blue[100]!,
                    context,
                  ),
                ],
              ),

              40.h,

              const Text(
                "Top Rated Doctors",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              12.h,

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: topDoctors.map((doctor) {
                    return DoctorInfos(doctor: doctor, width: 300);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
