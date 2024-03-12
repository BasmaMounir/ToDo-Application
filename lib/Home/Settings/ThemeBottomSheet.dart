import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_application/Providers/settings-provider.dart';
import 'package:to_do_application/my_theme.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return Container(
      padding: EdgeInsets.all(20),
      height: MediaQuery.of(context).copyWith().size.height * 0.2,
      color:
          provider.isDarkMode() ? MyTheme.darkBlackColor : MyTheme.wightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: () async {
                await provider.ChangeThemeMode(ThemeMode.light);
                Navigator.pop(context);
              },
              child: provider.isDarkMode()
                  ? unselectedItem(AppLocalizations.of(context)!.light)
                  : selectedItem(AppLocalizations.of(context)!.light)),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () async {
              await provider.ChangeThemeMode(ThemeMode.dark);
              Navigator.pop(context);
            },
            child: provider.isDarkMode()
                ? selectedItem(AppLocalizations.of(context)!.dark)
                : unselectedItem(AppLocalizations.of(context)!.dark),
          ),
        ],
      ),
    );
  }

  Widget selectedItem(String language) {
    var provider = Provider.of<SettingsProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          language,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: provider.isDarkMode()
                  ? MyTheme.greenColor
                  : MyTheme.primaryColor),
        ),
        Icon(
          Icons.check,
          size: 35,
          color:
              provider.isDarkMode() ? MyTheme.greenColor : MyTheme.primaryColor,
        ),
      ],
    );
  }

  Widget unselectedItem(String language) {
    var provider = Provider.of<SettingsProvider>(context);

    return Text(language,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: provider.isDarkMode()
                ? MyTheme.wightColor
                : MyTheme.blackColor));
  }
}
