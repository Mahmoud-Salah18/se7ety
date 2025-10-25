import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hint,
    this.validator,
    required this.controller,
    this.maxLines,
    this.suffixIcon,
    this.readOnly = false,
    this.onTap,
    this.prefixIcon,
  });

  final String? hint;
  final int? maxLines;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool readOnly;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      readOnly: readOnly,
      controller: controller,
      maxLines: maxLines,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
