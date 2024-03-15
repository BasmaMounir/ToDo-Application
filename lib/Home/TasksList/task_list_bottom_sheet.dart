import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_application/Home/Dialogues/dialog_utils.dart';
import 'package:to_do_application/ModelClass/task.dart';
import 'package:to_do_application/Providers/list_provider.dart';
import 'package:to_do_application/Providers/settings-provider.dart';
import 'package:to_do_application/firebase_utils.dart';
import 'package:to_do_application/my_theme.dart';

import '../../Providers/authProviders.dart';

class TaskListBottomSheet extends StatefulWidget {
  const TaskListBottomSheet({super.key});

  @override
  State<TaskListBottomSheet> createState() => _TaskListBottomSheetState();
}

class _TaskListBottomSheetState extends State<TaskListBottomSheet> {
  DateTime selectedDate = DateTime.now();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);
    var provider = Provider.of<SettingsProvider>(context);
    return Form(
      key: globalKey,
      child: Container(
        color:
            provider.isDarkMode() ? MyTheme.darkBlackColor : MyTheme.wightColor,
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              textAlign: TextAlign.center,
              AppLocalizations.of(context)!.addTask,
              style: Theme.of(context)!.textTheme.titleLarge!.copyWith(
                    fontSize: 18,
                    color: provider.isDarkMode()
                        ? MyTheme.wightColor
                        : MyTheme.blackColor,
                  ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              style: TextStyle(
                color: provider.isDarkMode()
                    ? MyTheme.wightColor
                    : MyTheme.blackColor,
              ),
              onChanged: (text) => title = text,
              validator: (value) => value!.isEmpty
                  ? AppLocalizations.of(context)!.titleValidation
                  : null,
              decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.title,
                  hintStyle: TextStyle(
                    color: provider.isDarkMode()
                        ? MyTheme.wightColor
                        : MyTheme.blackColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
            ),
            const SizedBox(height: 20),
            TextFormField(
              style: TextStyle(
                color: provider.isDarkMode()
                    ? MyTheme.wightColor
                    : MyTheme.blackColor,
              ),
              onChanged: (text) => description = text,
              validator: (value) => value!.isEmpty
                  ? AppLocalizations.of(context)!.descriptionValidation
                  : null,
              decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.description,
                  hintStyle: TextStyle(
                    color: provider.isDarkMode()
                        ? MyTheme.wightColor
                        : MyTheme.blackColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.selectDate,
              style: Theme.of(context)!.textTheme.titleLarge!.copyWith(
                    fontSize: 18,
                    color: provider.isDarkMode()
                        ? MyTheme.wightColor
                        : MyTheme.blackColor,
                  ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                return showCalender();
              },
              child: Text(
                textAlign: TextAlign.center,
                '${DateFormat('dd / MM / yyyy').format(selectedDate)}',
                style: Theme.of(context)!.textTheme.titleLarge!.copyWith(
                    fontSize: 15,
                    color: provider.isDarkMode()
                        ? MyTheme.grayColor
                        : MyTheme.deepGrayColor,
                    fontWeight: FontWeight.w300),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: MyTheme.primaryColor),
              onPressed: () {
                addTask();
              },
              child: Text(
                AppLocalizations.of(context)!.addTask,
                style: Theme.of(context)!
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showCalender() async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (chosenDate != null) {
      setState(() {
        selectedDate = chosenDate;
      });
    }
  }

  void addTask() {
    var authProvider = Provider.of<AuthProviders>(context, listen: false);

    if (globalKey.currentState!.validate()) {
      DialogUtils.Loading(context);
      Task task =
          Task(title: title, description: description, date: selectedDate);
      FirebaseUtils.AddTaskToFireStore(task, authProvider.currentUser!.id!)
          .then((value) {
        listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
        DialogUtils.hideDialog(context);
        Navigator.pop(context);
        DialogUtils.showMessage(context, message: 'Task Added Successfully');
      }).timeout(const Duration(milliseconds: 500), onTimeout: () {
        listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
        DialogUtils.hideDialog(context);
        Navigator.pop(context);
        DialogUtils.showMessage(context, message: 'Task Added Successfully');
      });
      // add task
    }
  }
}
