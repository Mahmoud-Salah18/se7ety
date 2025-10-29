import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/components/buttons/main_button.dart';
import 'package:se7ety/components/inputs/custom_text_field.dart';
import 'package:se7ety/components/inputs/password_text_field.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/models/user_type_enum.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.userType});
  final UserTypeEnum userType;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String handleUserType() {
    return widget.userType == UserTypeEnum.doctor ? "دكتور" : "مريض";
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leading: const BackButton(color: AppColors.secondColor),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          child: Padding(
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: Column(
              children: [
                Gap(40),
                Image.asset(AppImages.logo, height: 250),
                Gap(20),
                Text(
                  'تسجيل الدخول كــ "${handleUserType()}"',
                  style: TextStyles.title.copyWith(
                    color: AppColors.secondColor,
                  ),
                ),
                Gap(30),
                CustomTextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: cubit.emailController,
                  hint: "Mahmoud@example.com",
                  prefixIcon: Icon(Icons.email_rounded),
                  textAlign: TextAlign.end,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "من فضل دخل الايميل";
                    } else {
                      return null;
                    }
                  },
                ),
                Gap(25),
                PasswordTextField(
                  controller: cubit.passwordController,
                  hint: "*********",
                  prefixIcon: Icon(Icons.lock),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "من فضلك ادخل كلمة المرور";
                    } else {
                      return null;
                    }
                  },
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsetsDirectional.only(top: 10, start: 10),
                  child: Text("نسيت كلمة المرور ؟", style: TextStyles.small),
                ),
                Gap(20),
                MainButton(
                  text: "تسجيل الدخول",
                  onPressed: () async {
                    if (cubit.formKey.currentState!.validate()) {}
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ليس لدي حساب ؟",
                        style: TextStyles.body.copyWith(
                          color: AppColors.darkColor,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          pushWithReplacement(
                            context,
                            Routes.register,
                            extra: widget.userType,
                          );
                        },
                        child: Text(
                          "سجل الان",
                          style: TextStyles.body.copyWith(
                            color: AppColors.secondColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
