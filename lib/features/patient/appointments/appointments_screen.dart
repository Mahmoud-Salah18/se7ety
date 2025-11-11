import 'package:flutter/material.dart';
import 'package:se7ety/features/patient/appointments/appointments_list.dart';

class MyAppointmentsScreen extends StatefulWidget {
  const MyAppointmentsScreen({super.key});

  @override
  State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState extends State<MyAppointmentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("مواعيد الحجز")),
      body: Padding(padding: EdgeInsets.all(10), child: MyAppointmentList()),
    );
  }
}
