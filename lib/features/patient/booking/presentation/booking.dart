import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/components/alert_dialog.dart';
import 'package:se7ety/components/buttons/main_button.dart';
import 'package:se7ety/components/cards/doctor_card.dart';
import 'package:se7ety/core/functions/dialogs.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/services/firebase/firestore_services.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/models/doctor_model.dart';
import 'package:se7ety/features/patient/booking/data/appointment_model.dart';
import 'package:se7ety/features/patient/booking/data/available_appointment.dart';

class BookingFormScreen extends StatefulWidget {
  const BookingFormScreen({super.key, required this.doctor});
  final DoctorModel doctor;

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  int selectHour = -1;

  List<int> availableHours = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("احجز مع دكتور")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              DoctorCard(doctor: widget.doctor, isClickable: false),
              Gap(20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text("أدخل بيانات الحجز", style: TextStyles.title),
                    ),
                    Gap(15),
                    Text(
                      "اسم المريض",
                      style: TextStyles.body.copyWith(
                        color: AppColors.darkColor,
                      ),
                    ),
                    Gap(10),
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value!.isEmpty) return "من فضلك أدخل اسم المريض";
                        return null;
                      },
                      style: TextStyles.body,
                      textInputAction: TextInputAction.next,
                    ),
                    Gap(15),
                    Text(
                      "رقم الهاتف",
                      style: TextStyles.body.copyWith(
                        color: AppColors.darkColor,
                      ),
                    ),
                    Gap(10),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      style: TextStyles.body,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "من فضلك أدخل رقم الهاتف";
                        } else if (value.length < 10) {
                          return "يرجى أدخال رقم الهاتف صحيح";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    Gap(15),
                    Text(
                      "وصف الحاله",
                      style: TextStyles.body.copyWith(
                        color: AppColors.darkColor,
                      ),
                    ),
                    Gap(10),
                    TextFormField(
                      controller: _descriptionController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      style: TextStyles.body,
                      textInputAction: TextInputAction.next,
                    ),
                    Gap(15),
                    Text(
                      "تاريخ الحجز",
                      style: TextStyles.body.copyWith(
                        color: AppColors.darkColor,
                      ),
                    ),
                    Gap(10),
                    TextFormField(
                      readOnly: true,
                      onTap: () {
                        selectDate(context);
                      },
                      controller: _dateController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "من فضلك أدخل تاريخ الحجز";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      style: TextStyles.body,
                      decoration: InputDecoration(
                        hintText: "أدخل تاريخ الحجز",
                        suffixIcon: Padding(
                          padding: EdgeInsets.all(4),
                          child: CircleAvatar(
                            backgroundColor: AppColors.secondColor,
                            radius: 18,
                            child: Icon(
                              Icons.date_range_outlined,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Gap(15),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Text(
                            "وقت الحجز",
                            style: TextStyles.body.copyWith(
                              color: AppColors.darkColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(10),
                    Wrap(
                      spacing: 8,
                      children: [
                        for (var hour in availableHours)
                          ChoiceChip(
                            backgroundColor: AppColors.accentColor,
                            showCheckmark: true,
                            checkmarkColor: AppColors.whiteColor,
                            selectedColor: AppColors.secondColor,
                            label: Text(
                              "${(hour < 10) ? "0" : ""}"
                              "${(hour.toString())}"
                              ":00",
                              style: TextStyle(
                                color: hour == selectHour
                                    ? AppColors.whiteColor
                                    : AppColors.darkColor,
                              ),
                            ),
                            selected: hour == selectHour,
                            onSelected: (_) {
                              setState(() {
                                selectHour = hour;
                              });
                            },
                          ),
                      ],
                    ),
                    Gap(20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(12),
        child: MainButton(
          text: "تأكيد الحجز",
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (selectHour != -1) {
                _createAppointment();
              } else {
                showMyDialog(context, "من فضلك أختر وقت الحجز");
              }
            }
          },
        ),
      ),
    );
  }

  Future<void> _createAppointment() async {
    var appointmentData = AppointmentModel(
      id: "${DateTime.now().millisecondsSinceEpoch}",
      patientID: FirebaseAuth.instance.currentUser?.uid ?? "",
      doctorId: widget.doctor.uid ?? "",
      name: _nameController.text,
      doctorName: widget.doctor.name ?? "",
      phone: _phoneController.text,
      description: _descriptionController.text,
      location: widget.doctor.address ?? "",
      date: DateTime.parse(
        "${_dateController.text}${(selectHour < 10) ? "0" : ""} $selectHour:00:00",
      ),
      isComplete: false,
    );

    await FirestoreServices.createAppointment(appointmentData).then((_) {
      showAlertDialog(
        context,
        title: "تم تسجيل الحجز",
        ok: "اضغط للأنتقال",
        onTap: () {},
      );
      Future.delayed(Duration(seconds: 3), () {
        pop(context);
        goToBase(context, Routes.patientMain);
      });
    });
  }

  Future<void> selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    ).then((date) {
      if (date != null) {
        _dateController.text = DateFormat("yyyy-MM-dd").format(date);

        availableHours = getAvailableAppointments(
          date,
          widget.doctor.openHour ?? "0",
          widget.doctor.closeHour ?? "0",
        );
        setState(() {});
      }
    });
  }
}
