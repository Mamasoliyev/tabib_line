import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditDoctorScreen extends StatefulWidget {
  final String doctorId;
  final Map<String, dynamic> initialData;

  const EditDoctorScreen({
    super.key,
    required this.doctorId,
    required this.initialData,
  });

  @override
  State<EditDoctorScreen> createState() => _EditDoctorScreenState();
}

class _EditDoctorScreenState extends State<EditDoctorScreen> {
  late TextEditingController nameController;
  late TextEditingController positionController;
  late TextEditingController workplaceController;
  late TextEditingController aboutMeController;
  late TextEditingController experienceController;
  late TextEditingController imageController;
  late TextEditingController ratingController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.initialData['name']);
    positionController = TextEditingController(
      text: widget.initialData['position'],
    );
    workplaceController = TextEditingController(
      text: widget.initialData['workplace'],
    );
    aboutMeController = TextEditingController(
      text: widget.initialData['aboutMe'],
    );
    experienceController = TextEditingController(
      text: widget.initialData['experience'],
    );
    imageController = TextEditingController(text: widget.initialData['image']);
    ratingController = TextEditingController(
      text: widget.initialData['rating']?.toString(),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    positionController.dispose();
    workplaceController.dispose();
    aboutMeController.dispose();
    experienceController.dispose();
    imageController.dispose();
    ratingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Doctor")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Ism"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: positionController,
              decoration: const InputDecoration(labelText: "Lavozim"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: workplaceController,
              decoration: const InputDecoration(labelText: "Ish joyi"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: aboutMeController,
              decoration: const InputDecoration(labelText: "About Me"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: experienceController,
              decoration: const InputDecoration(labelText: "Tajriba"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: imageController,
              decoration: const InputDecoration(labelText: "Image URL"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: ratingController,
              decoration: const InputDecoration(labelText: "Rating"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('Doctors')
                    .doc(widget.doctorId)
                    .update({
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
                  const SnackBar(content: Text("Doctor tahrirlandi")),
                );
              },
              child: const Text("Saqlash"),
            ),
          ],
        ),
      ),
    );
  }
}
