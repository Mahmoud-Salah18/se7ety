import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/presentation/doctor/login/page/login_screen.dart';
import 'package:se7ety/features/auth/presentation/patient/login/page/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImages.welcome,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Gap(90),
                  Text(
                    'اهلا بيك',
                    style: TextStyles.styleSize30(color: AppColors.secondColor),
                    textAlign: TextAlign.right,
                  ),
                  Gap(8),
                  Text(
                    'سجل واحجز عند دكتورك وانت فالبيت',
                    style: TextStyles.styleSize18(color: AppColors.darkColor),
                    textAlign: TextAlign.right,
                  ),
                  Spacer(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 24,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.secondColor.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.whiteColor.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'سجل دلوقتي كـ',
                              style: TextStyles.styleSize24(
                                color: AppColors.whiteColor,
                              ),
                            ),
                            Gap(20),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              LoginScreenDoc(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.whiteColor
                                          .withOpacity(0.6),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      elevation: 0,
                                    ),
                                    child: Text(
                                      'دكتور',
                                      style: TextStyles.styleSize24(
                                        color: AppColors.darkColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Gap(16),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginScreen(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.whiteColor
                                          .withOpacity(0.6),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      elevation: 0,
                                    ),
                                    child: Text(
                                      'مريض',
                                      style: TextStyles.styleSize24(
                                        color: AppColors.darkColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Gap(90),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
