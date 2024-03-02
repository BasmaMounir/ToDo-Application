import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_application/Home/Settings/settings_tab.dart';
import 'package:to_do_application/Home/TasksList/task_list_bottom_sheet.dart';
import 'package:to_do_application/Home/TasksList/tasks_tab.dart';
import 'package:to_do_application/my_theme.dart';
class HomeScreen extends StatefulWidget {
  static const String routeName = 'home screen';

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.appTitle,
          style: Theme.of(context)!.textTheme.titleLarge,
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.2,
      ),
      bottomNavigationBar: BottomAppBar(
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
                  icon: Icon(Icons.list),
                  label: AppLocalizations.of(context)!.listTab),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: AppLocalizations.of(context)!.settingsTab),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyTheme.primaryColor,
        shape: StadiumBorder(
            side: BorderSide(color: MyTheme.wightColor, width: 5)),
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

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return TaskListBottomSheet();
        });
  }
}
