import 'package:flutter/material.dart';
import 'package:to_do_application/Home/Settings/title_drop_down_widget.dart';

class SettingsTab extends StatelessWidget {
  SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleAndDropDownWidget(
            title: 'Languages', content: ['English', 'Arabic']),
        TitleAndDropDownWidget(title: 'Theme', content: ['Dark', 'light']),
      ],
    );
  }
}