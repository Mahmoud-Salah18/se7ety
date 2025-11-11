import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/services/firebase/firestore_services.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/patient/booking/data/appointment_model.dart';

class MyAppointmentList extends StatefulWidget {
  const MyAppointmentList({super.key});

  @override
  State<MyAppointmentList> createState() => _MyAppointmentListState();
}

class _MyAppointmentListState extends State<MyAppointmentList> {
  bool _compareDate(DateTime date) {
    DateTime now = DateTime.now();
    if (now.year == date.year &&
        now.month == date.month &&
        now.day == date.day) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: FirestoreServices.getAppointmentsByPatientId(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return snapshot.data!.docs.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppImages.noScheduledSvg, width: 250),
                      Text("لا يوجد حجوزات قادمة", style: TextStyles.body),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data?.docs.length ?? 0,
                  separatorBuilder: (context, index) => Gap(15),
                  itemBuilder: (context, index) {
                    AppointmentModel model = AppointmentModel.fromJson(
                      snapshot.data!.docs[index].data() as Map<String, dynamic>,
                    );

                    return ExpansionTile(
                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(15),
                      ),
                      childrenPadding: EdgeInsets.symmetric(vertical: 10),
                      expandedCrossAxisAlignment: CrossAxisAlignment.end,
                      backgroundColor: AppColors.accentColor,
                      collapsedBackgroundColor: AppColors.accentColor,
                      title: Text(
                        "د. ${model.doctorName}",
                        style: TextStyles.title,
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 5, left: 5),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month_rounded,
                                  color: AppColors.secondColor,
                                  size: 16,
                                ),
                                Gap(10),
                                Text(
                                  DateFormat.yMMMMd(
                                    "ar",
                                  ).format(model.date).toString(),
                                  style: TextStyles.body,
                                ),
                                Gap(30),
                                Text(
                                  _compareDate(model.date) ? "اليوم" : "",
                                  style: TextStyles.body.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.watch_later_outlined,
                                  color: AppColors.secondColor,
                                  size: 16,
                                ),
                                Gap(10),
                                Text(
                                  DateFormat.jm(
                                    "ar",
                                  ).format(model.date).toString(),
                                  style: TextStyles.body,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 5,
                            right: 10,
                            left: 16,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "اسم المريض : ${model.name}",
                                style: TextStyles.body,
                              ),
                              Gap(10),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_rounded,
                                    color: AppColors.secondColor,
                                    size: 16,
                                  ),
                                  Gap(10),
                                  Text(model.location, style: TextStyles.body),
                                ],
                              ),
                              Gap(10),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: AppColors.whiteColor,
                                    backgroundColor: AppColors.redColor,
                                  ),
                                  onPressed: () {
                                    showAlertDialog(context, model.id);
                                  },
                                  child: Text("حذف الحجز"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
        },
      ),
    );
  }

  void showAlertDialog(BuildContext context, String docID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: Text("حذف الحجز"),
          content: Text("هل متأكد من حذف الحجز"),
          actions: [
            TextButton(
              child: Text("لا"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("نعم"),
              onPressed: () {
                FirestoreServices.deleteAppointment(docID).then((_) {
                  pop(context);
                  setState(() {});
                });
              },
            ),
          ],
        );
      },
    );
  }
}
