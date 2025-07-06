import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tabib_line/view/screens/add_doctor_screen.dart';
import 'package:tabib_line/view/screens/edit_doctor_screen.dart';

class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final doctorsCollection = FirebaseFirestore.instance.collection('Doctors');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Panel"),
        backgroundColor: const Color(0xFF254EDB),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: doctorsCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Xatolik: ${snapshot.error}"));
          }

          final doctors = snapshot.data?.docs ?? [];

          return ListView.builder(
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              final doctor = doctors[index];
              final data = doctor.data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(data['image'] ?? ''),
                    radius: 30,
                  ),
                  title: Text(data['name'] ?? ''),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data['position'] ?? ''),
                      Text(data['workplace'] ?? ''),
                      Text("Reyting: ${data['rating']?.toString() ?? '0'}"),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.orange),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditDoctorScreen(
                                doctorId: doctor.id,
                                initialData: data,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await doctorsCollection.doc(doctor.id).delete();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Doctor o‘chirildi")),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddDoctorScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
