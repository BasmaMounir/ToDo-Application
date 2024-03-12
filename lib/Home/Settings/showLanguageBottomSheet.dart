import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_application/Providers/settings-provider.dart';
import 'package:to_do_application/my_theme.dart';

class LanguageBottomSheet extends StatefulWidget {
  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return Container(
      height: MediaQuery.of(context).copyWith().size.height * 0.2,
      padding: EdgeInsets.all(20),
      color:
          provider.isDarkMode() ? MyTheme.darkBlackColor : MyTheme.wightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: () async {
                await provider.ChangeLanguage('en');
                Navigator.pop(context);
              },
              child: provider.appLanguage == 'en'
                  ? selectedItem(AppLocalizations.of(context)!.english)
                  : unselectedItem(AppLocalizations.of(context)!.english)),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () async {
              await provider.ChangeLanguage('ar');
              Navigator.pop(context);
            },
            child: provider.appLanguage == 'ar'
                ? selectedItem(AppLocalizations.of(context)!.arabic)
                : unselectedItem(AppLocalizations.of(context)!.arabic),
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
