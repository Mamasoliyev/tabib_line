import 'package:flutter/material.dart';
import 'package:tabib_line/models/appoinment_model.dart';
import 'package:tabib_line/service/appoinment_service.dart';

class PaymentScreen extends StatefulWidget {
  final AppointmentModel appointment;

  const PaymentScreen({super.key, required this.appointment});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedMethod = 'Cash';
  final List<String> methods = ['Cash', 'Card'];
  bool isLoading = false;

  Future<void> _submitPayment() async {
    bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tasdiqlash'),
        content: const Text("To'lovni tasdiqlaysizmi?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Yo'q"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Ha"),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() {
      isLoading = true;
    });

    try {
      final updated = widget.appointment.copyWith(
        status: "confirmed",
        paymentMethod: selectedMethod,
        doctorId:
            widget.appointment.doctorId, 
      );

      print("Booking appointment with data: ${updated.toMap()}");

      await AppointmentService().bookAppointment(updated);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("To'lov muvaffaqiyatli amalga oshirildi")),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Xatolik yuz berdi: $e")));
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("To'lov")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "To'lov usulini tanlang",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...methods.map((method) {
              return RadioListTile<String>(
                value: method,
                groupValue: selectedMethod,
                title: Text(method),
                onChanged: isLoading
                    ? null
                    : (value) {
                        setState(() {
                          selectedMethod = value!;
                        });
                      },
              );
            }).toList(),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: isLoading ? null : _submitPayment,
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
                child: isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        "To'lov va Tasdiqlash",
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
