import 'package:flutter/material.dart';
import 'package:tabib_line/view/widgets/category_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                  SizedBox(width: 8),
                  Text(
                    "Uzbekiston",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.green[100],
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://cdn.doctoranytime.gr/practices/b4da25df-d298-4b10-8627-e5664a7d2184.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(16),
                child: Column(
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
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Categories",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text("See All", style: TextStyle(color: Colors.blue)),
                ],
              ),
              const SizedBox(height: 12),

              Wrap(
                spacing: 10,
                runSpacing: 10,
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
                    "General",
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
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
