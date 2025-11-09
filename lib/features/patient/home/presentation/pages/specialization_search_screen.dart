import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:se7ety/components/cards/doctor_card.dart' show DoctorCard;
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/services/firebase/firestore_services.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/models/doctor_model.dart';

class SpecializationSearchScreen extends StatelessWidget {
  const SpecializationSearchScreen({super.key, required this.specialization});
  final String specialization;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.whiteColor,
        backgroundColor: AppColors.primaryColor,
        title: Text(specialization),
      ),
      body: FutureBuilder(
        future: FirestoreServices.filterDoctorsBySpecialization(specialization),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return snapshot.data?.docs.isEmpty == true
              ? EmptyWidget()
              : Padding(
                  padding: EdgeInsetsGeometry.all(15),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      DoctorModel doctor = DoctorModel.fromJson(
                        snapshot.data?.docs[index].data()
                            as Map<String, dynamic>,
                      );

                      return DoctorCard(doctor: doctor);
                    },
                  ),
                );
        },
      ),
    );
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppImages.noSearchSvg, width: 250),
            Text("لا يوجد دكتور بهذا التخصص", style: TextStyles.body),
          ],
        ),
      ),
    );
  }
}
