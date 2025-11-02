import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/patient/home/data/specialization_model.dart';

class SpecialistBanner extends StatelessWidget {
  const SpecialistBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("التخصصات", style: TextStyles.title.copyWith(fontSize: 16)),
        SizedBox(
          height: 230,
          width: double.infinity,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: cards.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: ItemCardWidget(model: cards[index]) ,
              );
            },
          ),
        ),
      ],
    );
  }
}

class ItemCardWidget extends StatelessWidget{

  const ItemCardWidget({super.key, required this.model});
  final SpecializationCardModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 150,
      margin:  EdgeInsets.only(left: 15, top: 10),
      decoration: BoxDecoration(
        color: model.cardBackground,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(offset: Offset(4, 4),
          blurRadius: 10,
          color: model.cardLightColor.withValues(alpha: .8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Stack(alignment: Alignment.center,
        children: [
          Positioned(top: -20,
          right: -20,
          child: CircleAvatar(
            backgroundColor: model.cardLightColor,
            radius: 60,
          ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset(AppImages.doctorCard,width: 140),
              Gap(10),
              Text(model.name,
              textAlign: TextAlign.center,
              style: TextStyles.title.copyWith(color: AppColors.whiteColor,
              fontSize: 14),
              ),
              Gap(20),
            ],
          )
        ],),
      ),
    );
  }
} 