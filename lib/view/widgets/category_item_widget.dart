import 'package:flutter/material.dart';
import 'package:tabib_line/utils/sizeBox.dart';
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
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
          10.h,
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
