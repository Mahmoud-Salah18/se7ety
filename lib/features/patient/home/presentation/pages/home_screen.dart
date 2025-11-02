import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/patient/home/presentation/widgets/specialist_widget.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<PatientHomeScreen> {
  final TextEditingController _doctorName = TextEditingController();
  User? user;

  Future<void> _getUser() async {
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsetsGeometry.only(left: 10),
            child: IconButton(
              splashRadius: 20,
              onPressed: () {},
              icon: Icon(
                Icons.notifications_active,
                color: AppColors.darkColor,
              ),
            ),
          ),
        ],
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        title: Text(
          "صحتي",
          style: TextStyles.title.copyWith(color: AppColors.darkColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "مرحبا",
                      style: TextStyles.body.copyWith(fontSize: 18),
                    ),
                    TextSpan(
                      text: user?.displayName,
                      style: TextStyles.body.copyWith(
                        color: AppColors.secondColor,
                      ),
                    ),
                    WidgetSpan(child: Icon(Icons.waving_hand, size: 20)),
                  ],
                ),
              ),
              Gap(20),
              Text(
                "احجز الان وكن جزءا من رحلتك الصحية.",
                style: TextStyles.title.copyWith(
                  color: AppColors.darkColor,
                  fontSize: 25,
                ),
              ),
              Gap(20),
              Container(
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.greyColor.withOpacity(.3),
                      blurRadius: 15,
                      offset: Offset(5, 5),
                    ),
                  ],
                ),
                child: TextFormField(
                  textInputAction: TextInputAction.search,
                  controller: _doctorName,
                  cursorColor: AppColors.secondColor,
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    hintText: "ابحث عن دكتور",
                    suffixIcon: Container(
                      decoration: BoxDecoration(
                        color: AppColors.secondColor.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: IconButton(
                        onPressed: () {
                          if (_doctorName.text.isNotEmpty) {}
                        },
                        iconSize: 20,
                        splashRadius: 20,
                        color: AppColors.whiteColor,
                        icon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  style: TextStyles.body,
                  onFieldSubmitted: (String value) {
                    if (_doctorName.text.isNotEmpty) {}
                  },
                ),
              ),
              Gap(20),
              const SpecialistBanner(),
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}
