import 'package:flutter/material.dart';
import 'package:tabib_line/utils/sizeBox.dart';

class DoctorInfos extends StatelessWidget {
  final Map<String, dynamic> doctor;
  final double width;
  final bool showTitle;

  const DoctorInfos({
    super.key,
    required this.doctor,
    required this.width,
    this.showTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    final reviews = doctor['reviews'] as Map<String, dynamic>? ?? {};
    final rating = doctor['rating']?.toDouble() ?? 0.0;
    final name = doctor['name'] ?? 'No name';
    final position = doctor['position'] ?? '';
    final workplace = doctor['workplace'] ?? 'No workplace';
    final imageUrl =
        doctor['image'] ??
        'https://tse4.mm.bing.net/th/id/OIP.l96BdnBni68Vv9r_AgP7UgHaHa';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle) ...[
          const Text(
            "Top Rated Doctors",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          12.h,
        ],
        Container(
          width: width,
          height: 150,
          margin: const EdgeInsets.only(right: 12),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      imageUrl,
                      width: 80,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  15.w,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        3.h,
                        Text(
                          'Dr. $name',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          position,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        6.h,
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 16,
                              color: Colors.orange,
                            ),
                            5.w,
                            Flexible(
                              child: Text(
                                workplace,
                                style: const TextStyle(fontSize: 13),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.orange,
                            ),
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
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
