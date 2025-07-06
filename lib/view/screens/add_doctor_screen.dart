import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddDoctorScreen extends StatefulWidget {
  const AddDoctorScreen({super.key});

  @override
  State<AddDoctorScreen> createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends State<AddDoctorScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final positionController = TextEditingController();
  final workplaceController = TextEditingController();
  final aboutMeController = TextEditingController();
  final experienceController = TextEditingController();
  final imageController = TextEditingController();
  final ratingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Doctor")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Ism"),
                validator: (v) => v!.isEmpty ? "To‘ldiring" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: positionController,
                decoration: const InputDecoration(labelText: "Lavozim"),
                validator: (v) => v!.isEmpty ? "To‘ldiring" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: workplaceController,
                decoration: const InputDecoration(labelText: "Ish joyi"),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: aboutMeController,
                decoration: const InputDecoration(labelText: "About Me"),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: experienceController,
                decoration: const InputDecoration(labelText: "Tajriba"),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: imageController,
                decoration: const InputDecoration(labelText: "Image URL"),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: ratingController,
                decoration: const InputDecoration(labelText: "Rating (0-5)"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await FirebaseFirestore.instance.collection('Doctors').add({
                      "name": nameController.text,
                      "position": positionController.text,
                      "workplace": workplaceController.text,
                      "aboutMe": aboutMeController.text,
                      "experience": experienceController.text,
                      "image": imageController.text,
                      "rating": double.tryParse(ratingController.text) ?? 0,
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Doctor qo‘shildi")),
                    );
                  }
                },
                child: const Text("Qo‘shish"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
