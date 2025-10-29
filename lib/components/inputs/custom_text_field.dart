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
    this.keyboardType,
    this.textAlign = TextAlign.start,
  });

  final String? hint;
  final int? maxLines;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool readOnly;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      readOnly: readOnly,
      controller: controller,
      maxLines: maxLines,
      textAlign: textAlign,
      // inputFormatters: [

      // ],
      onTap: onTap,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
