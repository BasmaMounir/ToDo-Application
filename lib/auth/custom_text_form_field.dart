import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_application/Providers/settings-provider.dart';
import 'package:to_do_application/my_theme.dart';

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
    var provider = Provider.of<SettingsProvider>(context);
    return TextFormField(
      style: TextStyle(
          color:
              provider.isDarkMode() ? MyTheme.wightColor : MyTheme.blackColor),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
            color: provider.isDarkMode()
                ? MyTheme.wightColor
                : MyTheme.blackColor),
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
