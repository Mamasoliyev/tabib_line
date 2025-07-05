import 'package:flutter/material.dart';
import 'package:tabib_line/view/screens/details_screen.dart';

Widget categoryItem(
  IconData icon,
  String title,
  Color color,
  BuildContext context,
) {
  final Map<String, String> specialtyMap = {
    "Dentistry": "Stomatolog",
    "Cardiology": "Kardiolog",
    "Pulmonology": "Pulmonolog",
    "Terapevty": "Terapevt",
    "Neurology": "Nevrolog",
    "Gastroen..": "Gastroenterolog",
    "Laboratory": "Laborant",
    "Vaccination": "Immunolog",
  };

  final String firestorePosition = specialtyMap[title] ?? title;

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailScreen(specialty: firestorePosition),
        ),
      );
    },
    child: Container(
      width: 70,
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Colors.black87),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
        ],
      ),
    ),
  );
}
