import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/colors.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    this.hint,
    this.validator,
    required this.controller,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
    this.prefixIcon,
  });

  final String? hint;
  final int? maxLines;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final bool readOnly;
  final VoidCallback? onTap;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      readOnly: widget.readOnly,
      controller: widget.controller,
      obscureText: _obscureText,
      maxLines: widget.maxLines,
      onTap: widget.onTap,
      decoration: InputDecoration(
        hintText: widget.hint,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: AppColors.secondColor,
          ),
        ),
      ),
    );
  }
}
