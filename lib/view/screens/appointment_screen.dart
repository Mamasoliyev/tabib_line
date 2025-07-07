import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tabib_line/models/appoinment_model.dart';
import 'package:tabib_line/models/doctor_model.dart';
import 'package:tabib_line/service/appoinment_service.dart';
import 'package:tabib_line/service/doctor_service.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final AppointmentService _appointmentService = AppointmentService();
  final DoctorService _doctorService = DoctorService();

  Future<DoctorModel?> _getDoctorById(String id) async {
    return await _doctorService.getDoctorById(id);
  }

  Future<void> _confirmAndDelete(String appointmentId) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Diqqat"),
        content: const Text(
          "Haqiqatan ham ushbu appointmentni o'chirmoqchimisiz?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("Bekor qilish"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("O'chirish"),
          ),
        ],
      ),
    );

    if (shouldDelete == true) {
      await _appointmentService.deleteAppointment(appointmentId);
      setState(() {});
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Appointment o'chirildi")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Booking")),
      body: FutureBuilder<List<AppointmentModel>>(
        future: _appointmentService.getAppointments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Hozircha appointmentlar yo'q"));
          }

          final appointments = snapshot.data!;

          return ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appointment = appointments[index];

              return FutureBuilder<DoctorModel?>(
                future: _getDoctorById(appointment.doctorId),
                builder: (context, doctorSnapshot) {
                  if (doctorSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.all(12),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final doctor = doctorSnapshot.data;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.person, size: 30),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    doctor != null
                                        ? "${doctor.name} - ${doctor.position}"
                                        : "Doctor topilmadi",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () =>
                                      _confirmAndDelete(appointment.id),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "📅 Sana: ${DateFormat('yyyy-MM-dd').format(appointment.date)}",
                            ),
                            Text("🕒 Vaqt: ${appointment.time}"),
                            Text(
                              "💰 To'lov: ${appointment.paymentMethod ?? "Nomalum"}",
                            ),
                            Text(
                              "📌 Holat: ${appointment.status}",
                              style: TextStyle(
                                color: appointment.status == "confirmed"
                                    ? Colors.green
                                    : Colors.orange,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
