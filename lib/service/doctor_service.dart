import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tabib_line/models/doctor_model.dart';

class DoctorService {
  final CollectionReference _doctorsCollection = FirebaseFirestore.instance
      .collection('Doctors');

  Future<List<DoctorModel>> getDoctors() async {
    final snapshot = await _doctorsCollection.get();
    return snapshot.docs
        .map(
          (doc) =>
              DoctorModel.fromMap(doc.data() as Map<String, dynamic>, doc.id),
        )
        .toList();
  }

  Stream<List<DoctorModel>> getDoctorsStream() {
    return _doctorsCollection.snapshots().map(
      (snapshot) => snapshot.docs
          .map(
            (doc) =>
                DoctorModel.fromMap(doc.data() as Map<String, dynamic>, doc.id),
          )
          .toList(),
    );
  }

  Future<void> addDoctor(DoctorModel doctor) async {
    await _doctorsCollection.add(doctor.toMap());
  }

  Future<void> updateDoctor(DoctorModel doctor) async {
    await _doctorsCollection.doc(doctor.id).update(doctor.toMap());
  }

  Future<void> deleteDoctor(String id) async {
    await _doctorsCollection.doc(id).delete();
  }

  Future<DoctorModel?> getDoctorById(String id) async {
    final doc = await FirebaseFirestore.instance
        .collection('Doctors')
        .doc(id)
        .get();
    if (doc.exists) {
      return DoctorModel.fromMap(doc.data()!, doc.id);
    }
    return null;
  }
}
