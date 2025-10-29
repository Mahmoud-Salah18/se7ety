import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/colors.dart';

class TextStyles {
  static const TextStyle headline = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subHeadline = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle title = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.secondColor,
  );

  static const TextStyle body = TextStyle(fontSize: 16);
  static const TextStyle small = TextStyle(fontSize: 14);
  static const TextStyle caption = TextStyle(fontSize: 12);
}
