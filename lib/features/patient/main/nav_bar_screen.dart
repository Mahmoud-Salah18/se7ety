import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/patient/appointments/appointments_screen.dart';
import 'package:se7ety/features/patient/home/presentation/pages/home_screen.dart';
import 'package:se7ety/features/patient/search/page/search_screen.dart';

class PatientMainScreen extends StatefulWidget {
  const PatientMainScreen({super.key});

  @override
  State<PatientMainScreen> createState() => _MainPageState();
}

class _MainPageState extends State<PatientMainScreen> {
  int _selectedIndex = 0;
  final List _pages = [
    PatientHomeScreen(),
    SearchScreen(),
    MyAppointmentsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: AppColors.darkColor.withOpacity(.2),
            ),
          ],
        ),
        child: GNav(
          curve: Curves.easeInOutExpo,
          rippleColor: AppColors.greyColor,
          hoverColor: AppColors.greyColor,
          haptic: true,
          tabBorderRadius: 20,
          gap: 5,
          activeColor: AppColors.whiteColor,
          padding: EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 12),
          duration: Duration(milliseconds: 400),
          tabBackgroundColor: AppColors.secondColor,
          textStyle: TextStyles.body.copyWith(color: AppColors.whiteColor),
          tabs: [
            GButton(iconSize: 28, icon: Icons.home, text: "الرئيسية"),
            GButton(icon: Icons.search, text: "البحث"),
            GButton(
              iconSize: 28,
              icon: Icons.calendar_month_rounded,
              text: "المواعيد",
            ),
            GButton(iconSize: 29, icon: Icons.person, text: "الحساب"),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
        ),
      ),
    );
  }
}
