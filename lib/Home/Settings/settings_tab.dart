import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_application/Home/Settings/ThemeBottomSheet.dart';
import 'package:to_do_application/Home/Settings/showLanguageBottomSheet.dart';
import 'package:to_do_application/Providers/settings-provider.dart';
import 'package:to_do_application/my_theme.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  late var provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<SettingsProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.language,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: provider.isDarkMode()
                  ? MyTheme.wightColor
                  : MyTheme.blackColor),
        ),
        InkWell(
          onTap: () {
            showLanguageBottomSheet();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: provider.isDarkMode()
                  ? MyTheme.darkBlackColor
                  : MyTheme.wightColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: MyTheme.primaryColor, width: 3),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  provider.appLanguage == 'en'
                      ? AppLocalizations.of(context)!.english
                      : AppLocalizations.of(context)!.arabic,
                  style: TextStyle(
                      color: MyTheme.primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: MyTheme.primaryColor,
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          AppLocalizations.of(context)!.theme,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: provider.isDarkMode()
                  ? MyTheme.wightColor
                  : MyTheme.blackColor),
        ),
        InkWell(
          onTap: () {
            showThemeBottomSheet();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: provider.isDarkMode()
                  ? MyTheme.darkBlackColor
                  : MyTheme.wightColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: MyTheme.primaryColor, width: 3),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  provider.isDarkMode()
                      ? AppLocalizations.of(context)!.dark
                      : AppLocalizations.of(context)!.light,
                  style: TextStyle(
                      color: MyTheme.primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: MyTheme.primaryColor,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return LanguageBottomSheet();
        });
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ThemeBottomSheet();
        });
  }
}
