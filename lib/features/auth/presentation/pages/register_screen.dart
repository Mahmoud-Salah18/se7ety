import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/components/buttons/main_button.dart';
import 'package:se7ety/components/inputs/custom_text_field.dart';
import 'package:se7ety/components/inputs/password_text_field.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/functions/dialogs.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/models/user_type_enum.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.userType});
  final UserTypeEnum userType;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String handleUserType() {
    return widget.userType == UserTypeEnum.doctor ? "دكتور" : "مريض";
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leading: BackButton(color: AppColors.secondColor),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoadingState) {
            showLoadingDialog(context);
          } else if (state is AuthSuccessState) {
            pop(context);
            if (widget.userType == UserTypeEnum.doctor) {
              pushTo(context, Routes.doctorRegistration);
            } else {
              goToBase(context, Routes.patientMain);
            }
          } else if (state is AuthErrorState) {
            pop(context);
            showMyDialog(context, state.message);
          }
        },
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: cubit.formKey,
            child: Padding(
              padding: EdgeInsets.only(right: 16, left: 16),
              child: Column(
                children: [
                  Gap(40),
                  Image.asset(AppImages.logo, height: 250),
                  Gap(20),
                  Text(
                    "سجل حساب كــ ${handleUserType()}",
                    style: TextStyles.title.copyWith(
                      color: AppColors.secondColor,
                    ),
                  ),
                  Gap(30),
                  CustomTextField(
                    controller: cubit.nameController,
                    keyboardType: TextInputType.text,
                    hint: "اسم المستخدم",
                    prefixIcon: Icon(Icons.person),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "من فضلك دخل الاسم";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Gap(25),
                  CustomTextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: cubit.emailController,
                    hint: "Mahmoud@example.com",
                    prefixIcon: Icon(Icons.email_rounded),
                    textAlign: TextAlign.end,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "من فضلك دخل الايميل";
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
                  Gap(20),
                  MainButton(
                    text: "تسجيل حساب جديد",
                    onPressed: () async {
                      if (cubit.formKey.currentState!.validate()) {
                        await cubit.register(type: widget.userType);
                      }
                    },
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "لدي حساب ؟",
                          style: TextStyles.body.copyWith(
                            color: AppColors.darkColor,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            pushWithReplacement(
                              context,
                              Routes.login,
                              extra: widget.userType,
                            );
                          },
                          child: Text(
                            "سجل دخول",
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
      ),
    );
  }
}
