import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tabib_line/models/appoinment_model.dart';
import 'package:tabib_line/models/doctor_model.dart';
import 'package:tabib_line/view/screens/payment_screen.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingScreen extends StatefulWidget {
  // final DoctorModel doctorModel;
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime focusedDay = DateTime.now();
  DateTime selectedDate = DateTime.now();
  String selectedTime = '10:00 AM';

  final List<String> timeSlots = [
    '09:00 AM',
    '09:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '03:00 PM',
    '03:30 PM',
    '04:00 PM',
    '04:30 PM',
    '05:00 PM',
    '05:30 PM',
  ];

  void _goToPaymentScreen() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final appointment = AppointmentModel(
      id: '',
      userId: user.uid,
      date: selectedDate,
      time: selectedTime,
      status: 'pending',
      doctorId: "",
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(appointment: appointment),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('MMMM dd, yyyy').format(selectedDate);
    final weekDay = DateFormat('EEEE').format(selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Appointment"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Date",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    TableCalendar(
                      focusedDay: focusedDay,
                      firstDay: DateTime.now(),
                      lastDay: DateTime.now().add(const Duration(days: 60)),
                      selectedDayPredicate: (day) =>
                          isSameDay(selectedDate, day),
                      onDaySelected: (selected, focused) {
                        setState(() {
                          selectedDate = selected;
                          focusedDay = focused;
                        });
                      },
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                      ),
                      calendarStyle: CalendarStyle(
                        selectedDecoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "$formattedDate  ($weekDay)",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ),
            const Text(
              "Select Time",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2.5,
              physics: const NeverScrollableScrollPhysics(),
              children: timeSlots.map((time) {
                return ElevatedButton(
                  onPressed: () {
                    setState(() => selectedTime = time);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedTime == time
                        ? Colors.black
                        : Colors.white,
                    foregroundColor: selectedTime == time
                        ? Colors.white
                        : Colors.black,
                    side: const BorderSide(color: Colors.black12),
                  ),
                  child: Text(time),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: _goToPaymentScreen,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Payment",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
