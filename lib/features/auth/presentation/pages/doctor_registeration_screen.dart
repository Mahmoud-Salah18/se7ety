import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se7ety/components/buttons/main_button.dart';
import 'package:se7ety/components/inputs/custom_text_field.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/functions/dialogs.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/models/specializations.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_state.dart';

class DoctorRegistrationScreen extends StatefulWidget {
  const DoctorRegistrationScreen({super.key});

  @override
  State<DoctorRegistrationScreen> createState() =>
      _DoctorRegistrationScreenState();
}

class _DoctorRegistrationScreenState extends State<DoctorRegistrationScreen> {
  File? file;
  bool isShowError = false;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      setState(() {
        file = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return Scaffold(
      appBar: AppBar(title: Text("إكمال عملية التسجيل")),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoadingState) {
            showLoadingDialog(context);
          } else if (state is AuthSuccessState) {
            pop(context);
            log("Doctor Updated data");
          } else if (state is AuthErrorState) {
            pop(context);
            showMyDialog(context, state.message);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        await _pickImage();
                      },
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: AppColors.whiteColor,
                            backgroundImage: (file != null)
                                ? FileImage(file!)
                                : AssetImage(AppImages.doctor),
                          ),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: AppColors.whiteColor,
                            child: Icon(
                              Icons.camera_alt_rounded,
                              size: 20,
                              color: AppColors.secondColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(20),
                  Text("التخصص"),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.accentColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: DropdownButton<String?>(
                      isExpanded: true,
                      iconEnabledColor: AppColors.secondColor,
                      underline: SizedBox(),
                      hint: Text(
                        "اختر التخصص",
                        style: TextStyles.body.copyWith(
                          color: AppColors.whiteColor,
                        ),
                      ),

                      icon: Icon(Icons.expand_circle_down_outlined),
                      value: cubit.specializations,
                      onChanged: (String? newValue) {
                        setState(() {
                          cubit.specializations = newValue;
                        });
                      },
                      items: [
                        for (var specialization in specializations)
                          DropdownMenuItem(
                            value: specialization,
                            child: Text(specialization),
                          ),
                      ],
                    ),
                  ),
                  if (cubit.specializations == null && isShowError)
                    Text(
                      "من فضلك اختر التخصص",
                      style: TextStyles.caption.copyWith(
                        color: AppColors.redColor,
                      ),
                    ),
                  Gap(15),
                  Text(
                    "نبذة تعريفية",
                    style: TextStyles.body.copyWith(color: AppColors.darkColor),
                  ),
                  Gap(10),
                  CustomTextField(
                    controller: cubit.bioController,
                    maxLines: 5,
                    hint: "سجل المعلومات الطبية",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "من فضلك ادخل النبذة التعريفية";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Gap(15),
                  Divider(),
                  Gap(15),
                  Text(
                    "عنوان العيادة",
                    style: TextStyles.body.copyWith(color: AppColors.darkColor),
                  ),
                  Gap(10),
                  CustomTextField(
                    controller: cubit.addressController,
                    hint: "شارع مصدق - الدقي الجيزة",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "من فضلك ادخل عنوان العيادة";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Gap(15),
                  _workHours(cubit),
                  Gap(15),
                  _phoneNumbers(cubit),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: EdgeInsets.all(10),
          child: SizedBox(
            width: double.infinity,
            height: 55,
            child: MainButton(
              onPressed: () async {
                if (cubit.formKey.currentState!.validate()) {
                  if (file != null) {
                    cubit.updateDoctorData(file);
                  } else {
                    showMyDialog(context, "من فضلك أدخل الصورة");
                  }
                }
              },
              text: "التسجيل",
            ),
          ),
        ),
      ),
    );
  }

  Column _workHours(AuthCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "ساعات العمل من",
                style: TextStyles.body.copyWith(color: AppColors.darkColor),
              ),
            ),
            Gap(15),
            Expanded(
              child: Text(
                "إلى",
                style: TextStyles.body.copyWith(color: AppColors.darkColor),
              ),
            ),
          ],
        ),
        Gap(10),
        SizedBox(
          height: 60,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomTextField(
                  readOnly: true,
                  controller: cubit.openHourController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "مطلوب";
                    } else {
                      return null;
                    }
                  },
                  onTap: () async {
                    await showStartTimePicker(cubit);
                  },
                  suffixIcon: Icon(
                    Icons.watch_later_outlined,
                    color: AppColors.secondColor,
                  ),
                  hint: "00:00",
                ),
              ),
              Gap(10),
              Expanded(
                child: CustomTextField(
                  readOnly: true,
                  controller: cubit.closeHourController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "مطلوب";
                    } else {
                      return null;
                    }
                  },
                  onTap: () async {
                    await showEndTimePicker(cubit);
                  },
                  suffixIcon: Icon(
                    Icons.watch_later_outlined,
                    color: AppColors.secondColor,
                  ),
                  hint: "00:00",
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _phoneNumbers(AuthCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "رقم الهاتف 1",
          style: TextStyles.body.copyWith(color: AppColors.darkColor),
        ),
        Gap(10),
        CustomTextField(
          controller: cubit.phone1Controller,
          keyboardType: TextInputType.number,
          hint: "+20xxxxxxxxxx",
          validator: (value) {
            if (value!.isEmpty) {
              return "من فضلك ادخل الرقم";
            } else {
              return null;
            }
          },
        ),
        Gap(15),
        Text(
          "رقم الهاتف 2",
          style: TextStyles.body.copyWith(color: AppColors.darkColor),
        ),
        Gap(10),
        CustomTextField(
          controller: cubit.phone2Controller,
          keyboardType: TextInputType.number,
          hint: "+20xxxxxxxxxx",
        ),
      ],
    );
  }

  Future<void> showStartTimePicker(AuthCubit cubit) async {
    final startTimePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (startTimePicked != null) {
      cubit.openHourController.text = startTimePicked.hour.toString();
    }
  }

  Future<void> showEndTimePicker(AuthCubit cubit) async {
    final endTimePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (endTimePicked != null) {
      cubit.closeHourController.text = endTimePicked.hour.toString();
    }
  }
}
