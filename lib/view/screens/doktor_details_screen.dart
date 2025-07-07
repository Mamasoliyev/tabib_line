import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tabib_line/utils/sizeBox.dart';
import 'package:tabib_line/view/screens/home_screen.dart';

class DoctorDetailScreen extends StatefulWidget {
  final Map<String, dynamic> doctor;
  final String? doctorId;

  const DoctorDetailScreen({super.key, required this.doctor, this.doctorId});

  @override
  State<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  late TextEditingController reviewController;
  int selectedStars = 0;

  @override
  void initState() {
    super.initState();
    reviewController = TextEditingController();
  }

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  Future<void> submitReview() async {
    if (selectedStars == 0 || reviewController.text.trim().isEmpty) return;

    final docRef = FirebaseFirestore.instance
        .collection('doctors')
        .doc(widget.doctorId);
    final snapshot = await docRef.get();
    final currentData = snapshot.data() as Map<String, dynamic>?;

    if (currentData == null) return;

    final reviews = (currentData['reviews'] as Map<String, dynamic>?) ?? {};

    final userId = 'currentUser';
    reviews[userId] = {
      'rating': selectedStars,
      'review': reviewController.text.trim(),
      'timestamp': Timestamp.now(),
    };

    await docRef.update({'reviews': reviews});

    setState(() {
      selectedStars = 0;
      reviewController.clear();
    });
  }

  double calculateAverageRating(Map<String, dynamic> reviews) {
    if (reviews.isEmpty) return 0.0;
    final int totalStars = reviews.values.fold(
      0,
      (sum, review) => sum + ((review['rating'] ?? 0) as int),
    );

    return totalStars / reviews.length;
  }

  @override
  Widget build(BuildContext context) {
    final doctor = widget.doctor;
    final name = doctor['name'] ?? 'No name';
    final position = doctor['position'] ?? '';
    final workplace = doctor['workplace'] ?? 'No workplace';
    final imageUrl = doctor['image'];
    final rating = doctor['rating']?.toDouble() ?? 0.0;
    final reviews = doctor['reviews'] as Map<String, dynamic>? ?? {};

    return Scaffold(
      appBar: AppBar(title: Text('Dr. $name')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(imageUrl),
              ),
            ),
            20.h,
            Text(
              'Dr. $name',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              position,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            8.h,
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.orange),
                5.w,
                Text(workplace, style: const TextStyle(fontSize: 14)),
              ],
            ),

            Row(
              children: [
                const Icon(Icons.star, size: 16, color: Colors.orange),
                5.w,
                Text(
                  rating.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 13),
                ),
                10.w,
                Text(
                  '${reviews.length} Reviews',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6C6C6C),
                  ),
                ),
              ],
            ),
            20.h,
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('doctors')
                  .doc(widget.doctorId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data?.data() == null) {
                  return const Center(child: Text("Doctor data not found."));
                }

                final data = snapshot.data!.data() as Map<String, dynamic>;
                final reviews =
                    (data['reviews'] as Map<String, dynamic>?) ?? {};
                final avgRating = calculateAverageRating(reviews);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.orange),
                        5.w,
                        Text(
                          avgRating.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 16),
                        ),
                        10.w,
                        Text(
                          '${reviews.length} Reviews',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),

                    20.h,
                    const Text(
                      'Reviews',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    10.h,
                    ...reviews.entries.map((entry) {
                      final review = entry.value;
                      return ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(review['review'] ?? ''),
                        subtitle: Row(
                          children: List.generate(
                            review['rating'] ?? 0,
                            (index) => const Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                );
              },
            ),
            30.h,

            const Text(
              'Write a Review',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            10.h,
            Row(
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < selectedStars ? Icons.star : Icons.star_border,
                    color: Colors.orange,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedStars = index + 1;
                    });
                  },
                );
              }),
            ),
            TextField(
              controller: reviewController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Your review',
                border: OutlineInputBorder(),
              ),
            ),
            15.h,
            ElevatedButton(
              onPressed: submitReview,
              child: const Text('Submit'),
            ),

            20.h,
            Center(
              child: TextButton(
                style: TextButton.styleFrom(minimumSize: Size(400, 50)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => HomeScreen(),
                    ), //! change screen
                  );
                },
                child: Text(
                  "Booking",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
