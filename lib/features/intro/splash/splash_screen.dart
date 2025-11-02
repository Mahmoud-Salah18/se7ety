import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/services/local/shared_pref.dart';
import 'package:se7ety/core/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    bool isOnboardingSeen = SharedPref.isOnboardingSeen();
    User? user = FirebaseAuth.instance.currentUser;
    Future.delayed(const Duration(seconds: 3), () {
      if (user != null) {
        if (user.photoURL == "doctor") {
          // pushWithReplacement(context, Routes.);
        } else {
          pushWithReplacement(context, Routes.patientMain);
        }
      } else {
        if (isOnboardingSeen) {
          pushWithReplacement(context, Routes.welcome);
        } else {
          pushWithReplacement(context, Routes.onboarding);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.accentColor,
      body: Center(child: Image.asset(AppImages.logo, width: 250)),
    );
  }
}
