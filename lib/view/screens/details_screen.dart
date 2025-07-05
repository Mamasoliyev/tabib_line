import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
          : ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                final doctor = doctors[index];
                final reviews =
                    doctor['reviews'] as Map<String, dynamic>? ?? {};
                final rating = doctor['rating']?.toDouble() ?? 0.0;
                final name = doctor['name'] ?? 'No name';
                final position = doctor['position'] ?? '';
                final workplace = reviews.isNotEmpty
                    ? reviews['workplace'] ?? ''
                    : 'Unknown workplace';
                final imageUrl =
                    doctor['image'] ??
                    'https://tse4.mm.bing.net/th/id/OIP.l96BdnBni68Vv9r_AgP7UgHaHa?r=0&rs=1&pid=ImgDetMain&o=7&rm=3';

                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            imageUrl,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dr. $name',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                position,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: Colors.orange,
                                  ),
                                  SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      workplace,
                                      style: TextStyle(fontSize: 13),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.orange,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    rating.toStringAsFixed(1),
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    '${reviews.length} Reviews',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        IconButton(
                          icon: Icon(Icons.favorite_border),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
