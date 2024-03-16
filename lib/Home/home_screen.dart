import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_application/Home/Settings/settings_tab.dart';
import 'package:to_do_application/Home/TasksList/task_list_bottom_sheet.dart';
import 'package:to_do_application/Home/TasksList/tasks_tab.dart';
import 'package:to_do_application/Providers/authProviders.dart';
import 'package:to_do_application/Providers/list_provider.dart';
import 'package:to_do_application/Providers/settings-provider.dart';
import 'package:to_do_application/auth/login/login.dart';
import 'package:to_do_application/my_theme.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    var listProvider = Provider.of<ListProvider>(context);
    var authProvider = Provider.of<AuthProviders>(context);

    return Scaffold(
      backgroundColor:
          provider.isDarkMode() ? MyTheme.darkBody : MyTheme.lightBody,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                listProvider.tasksList = [];
                authProvider.currentUser = null;
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              icon: Icon(Icons.logout_rounded))
        ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.appTitle,
              style: Theme.of(context)!.textTheme.titleLarge,
            ),
            ShowUserName()
          ],
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.2,
      ),
      bottomNavigationBar: BottomAppBar(
        color:
        provider.isDarkMode() ? MyTheme.darkBlackColor : MyTheme.wightColor,
        notchMargin: 8,
        child: SingleChildScrollView(
          child: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            currentIndex: selectedIndex,
            items: [
              BottomNavigationBarItem(
                  icon: const Icon(Icons.list),
                  label: AppLocalizations.of(context)!.listTab),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.settings),
                  label: AppLocalizations.of(context)!.settingsTab),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyTheme.primaryColor,
        shape: StadiumBorder(
            side: BorderSide(
                color: provider.isDarkMode()
                    ? MyTheme.darkBlackColor
                    : MyTheme.wightColor,
                width: 5)),
        onPressed: () {
          return showAddTaskBottomSheet();
        },
        child: Icon(
          color: MyTheme.wightColor,
          Icons.add,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: selectedIndex == 0 ? TasksTab() : SettingsTab(),
    );
  }

  Widget ShowUserName() {
    var authProvider = Provider.of<AuthProviders>(context, listen: false);

    return SizedBox(
      width: 250.0,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 30.0,
          fontFamily: 'Agne',
        ),
        child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
                '${AppLocalizations.of(context)!.welcome} ${authProvider.currentUser!.name!}'),
          ],
          onTap: () {
            print("Tap Event");
          },
        ),
      ),
    );
  }

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (buildContext) {
          return const TaskListBottomSheet();
        });
  }
}
