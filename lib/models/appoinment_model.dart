import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  final String id;
  final String userId;
  final String doctorId;
  final DateTime date;
  final String time;
  final String status;
  final String? paymentMethod;

  AppointmentModel({
    required this.id,
    required this.userId,
    required this.doctorId,
    required this.date,
    required this.time,
    required this.status,
    this.paymentMethod,
  });

  AppointmentModel copyWith({
    String? id,
    String? userId,
    String? doctorId,
    DateTime? date,
    String? time,
    String? status,
    String? paymentMethod,
  }) {
    return AppointmentModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      doctorId: doctorId ?? this.doctorId,
      date: date ?? this.date,
      time: time ?? this.time,
      status: status ?? this.status,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'doctorId': doctorId,
      'date': Timestamp.fromDate(date),
      'time': time,
      'status': status,
      'paymentMethod': paymentMethod,
    };
  }

  factory AppointmentModel.fromMap(
    Map<String, dynamic> map,
    String documentId,
  ) {
    return AppointmentModel(
      id: documentId,
      userId: map['userId'] ?? '',
      doctorId: map['doctorId'] ?? '',
      date: (map['date'] as Timestamp).toDate(),
      time: map['time'] ?? '',
      status: map['status'] ?? '',
      paymentMethod: map['paymentMethod'],
    );
  }
}
