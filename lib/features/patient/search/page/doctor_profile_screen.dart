import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/components/buttons/main_button.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/models/doctor_model.dart';
import 'package:se7ety/features/patient/search/widget/item_tile.dart';
import 'package:se7ety/features/patient/search/widget/phone_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key, this.doctorModel});
  final DoctorModel? doctorModel;

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  late DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("بيانات الدكتور")),
      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(20),
              Row(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: AppColors.whiteColor,
                        child: CircleAvatar(
                          backgroundColor: AppColors.whiteColor,
                          radius: 60,
                          backgroundImage: (widget.doctorModel?.image != null)
                              ? NetworkImage(widget.doctorModel!.image!)
                              : AssetImage(AppImages.doctor),
                        ),
                      ),
                    ],
                  ),
                  Gap(30),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "د. ${widget.doctorModel?.name ?? ""}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.title,
                        ),
                        Gap(10),
                        Text(
                          widget.doctorModel?.specialization ?? "",
                          style: TextStyles.body,
                        ),
                        Gap(10),
                        Row(
                          children: [
                            Text(
                              widget.doctorModel?.rating.toString() ?? "0.0",
                              style: TextStyles.body,
                            ),
                            Gap(3),
                            Icon(
                              Icons.star_rounded,
                              size: 20,
                              color: Colors.orange,
                            ),
                          ],
                        ),
                        Gap(15),
                        Row(
                          children: [
                            IconTile(
                              onTap: () {
                                var phone = Uri.parse(
                                  "tel:${widget.doctorModel?.phone1 ?? ""}",
                                );
                                launchUrl(phone);
                              },
                              backColor: AppColors.accentColor,
                              imageAssetPath: Icons.phone,
                              num: "1",
                            ),
                            if (widget.doctorModel?.phone2?.isNotEmpty == true)
                              IconTile(
                                onTap: () {
                                  var phone = Uri.parse(
                                    "tel:${widget.doctorModel?.phone2 ?? ""}",
                                  );
                                  launchUrl(phone);
                                },
                                backColor: AppColors.accentColor,
                                imageAssetPath: Icons.phone,
                                num: "2",
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Gap(25),
              Text(
                "نبذه تعريفية",
                style: TextStyles.body.copyWith(fontWeight: FontWeight.bold),
              ),
              Gap(10),
              Text(widget.doctorModel?.bio ?? "", style: TextStyles.small),
              Gap(20),
              Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.accentColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TileWidget(
                      text:
                          "${widget.doctorModel?.openHour} - ${widget.doctorModel?.closeHour}",
                      icon: Icons.watch_later_outlined,
                    ),
                    Gap(15),
                    TileWidget(
                      text: widget.doctorModel?.address ?? "",
                      icon: Icons.location_on_rounded,
                    ),
                  ],
                ),
              ),
              Divider(),
              Gap(20),
              Text(
                "معلومات الاتصال",
                style: TextStyles.body.copyWith(fontWeight: FontWeight.bold),
              ),
              Gap(10),
              Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.accentColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TileWidget(
                      text: widget.doctorModel?.email ?? "",
                      icon: Icons.email,
                    ),
                    Gap(15),
                    TileWidget(
                      text: widget.doctorModel?.phone1 ?? "",
                      icon: Icons.call,
                    ),
                    if (widget.doctorModel?.phone2?.isNotEmpty == true) ...[
                      Gap(15),
                      TileWidget(
                        text: widget.doctorModel?.phone2 ?? "",
                        icon: Icons.call,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(12),
          child: MainButton(text: "احجز موعد الان", onPressed: () {}),
        ),
      ),
    );
  }
}
