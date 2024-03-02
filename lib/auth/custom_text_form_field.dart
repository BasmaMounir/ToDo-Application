import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  String labelText;
  TextEditingController controller;
  int maxLines;
  int minLines;
  String? Function(String?)? validation;
  bool isobscureText;
  bool isPasswordVisible = false;

  CustomTextFormField({
    required this.labelText,
    this.isobscureText = false,
    required this.controller,
    required this.validation,
    this.maxLines = 1,
    this.minLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        suffixIcon: Icon(isPasswordVisible ? Icons.remove_red_eye : null),
      ),
      obscureText: isobscureText,
      maxLines: maxLines,
      minLines: minLines,
      controller: controller,
      validator: validation,
    );
  }
}
