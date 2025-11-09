import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';

class TileWidget extends StatelessWidget {
  const TileWidget({super.key, required this.text, required this.icon});
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(30),
          child: Container(
            height: 27,
            width: 27,
            color: AppColors.secondColor,
            child: Icon(icon, color: AppColors.whiteColor, size: 16),
          ),
        ),
        Gap(10),
        Expanded(child: Text(text, style: TextStyles.body)),
      ],
    );
  }
}
