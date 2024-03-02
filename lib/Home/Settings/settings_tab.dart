import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_application/Home/Settings/title_drop_down_widget.dart';

class SettingsTab extends StatelessWidget {
  SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleAndDropDownWidget(
            title: AppLocalizations.of(context)!.language,
            content: [
              AppLocalizations.of(context)!.english,
              AppLocalizations.of(context)!.arabic
            ]),
        TitleAndDropDownWidget(
            title: AppLocalizations.of(context)!.theme,
            content: [
              AppLocalizations.of(context)!.dark,
              AppLocalizations.of(context)!.light
            ]),
      ],
    );
  }
}