import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tabib_line/models/appoinment_model.dart';

class AppointmentService {
  final CollectionReference _collection = FirebaseFirestore.instance.collection(
    'appointments',
  );

  Future<List<AppointmentModel>> getAppointments() async {
    final snapshot = await _collection.get();
    return snapshot.docs
        .map(
          (doc) => AppointmentModel.fromMap(
            doc.data() as Map<String, dynamic>,
            doc.id,
          ),
        )
        .toList();
  }

  Stream<List<AppointmentModel>> getAppointmentsStream() {
    return _collection.snapshots().map(
      (snapshot) => snapshot.docs
          .map(
            (doc) => AppointmentModel.fromMap(
              doc.data() as Map<String, dynamic>,
              doc.id,
            ),
          )
          .toList(),
    );
  }

  Future<void> addAppointment(AppointmentModel appointment) async {
    await _collection.add(appointment.toMap());
  }

  Future<void> updateAppointment(AppointmentModel appointment) async {
    await _collection.doc(appointment.id).update(appointment.toMap());
  }

  Future<void> bookAppointment(AppointmentModel appointment) async {
    await FirebaseFirestore.instance
        .collection('appointments')
        .doc(appointment.id)
        .update(appointment.toMap());
  }

  Future<void> deleteAppointment(String id) async {
    await FirebaseFirestore.instance
        .collection('appointments')
        .doc(id)
        .delete();
  }
}
