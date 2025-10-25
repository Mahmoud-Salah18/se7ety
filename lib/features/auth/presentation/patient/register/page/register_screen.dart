import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/components/inputs/custom_text_field.dart';
import 'package:se7ety/components/inputs/password_text_field.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/presentation/patient/login/page/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [Image.asset(AppImages.logo, height: 250), Gap(10)],
                ),
                Gap(40),
                Text(
                  'سجل حساب جديد كـ مريض',
                  style: TextStyles.styleSize24(color: AppColors.secondColor),
                ),
                Gap(30),
                CustomTextField(
                  hint: 'الاسم',
                  controller: emailController,
                  suffixIcon: Icon(Icons.person, color: AppColors.secondColor),
                ),
                Gap(20),
                CustomTextField(
                  hint: 'أدخل بريدك الالكتروني',
                  controller: emailController,
                  suffixIcon: Icon(
                    Icons.email_outlined,
                    color: AppColors.secondColor,
                  ),
                ),
                Gap(20),
                PasswordTextField(
                  hint: 'كلمة السر',
                  controller: passwordController,
                ),
                Gap(30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {},
                    child: Text(
                      'تسجيل حساب',
                      style: TextStyles.styleSize24(
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
                Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'سجل دخول',
                        style: TextStyles.styleSize18(
                          color: AppColors.secondColor,
                        ),
                      ),
                    ),
                    Text(
                      'لدي حساب؟',
                      style: TextStyles.styleSize18(color: AppColors.darkColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
