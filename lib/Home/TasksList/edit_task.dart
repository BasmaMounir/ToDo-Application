import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_application/Home/Dialogues/dialog_utils.dart';
import 'package:to_do_application/Providers/settings-provider.dart';
import 'package:to_do_application/firebase_utils.dart';
import 'package:to_do_application/my_theme.dart';

import '../../ModelClass/task.dart';
import '../../Providers/list_provider.dart';

class EditTask extends StatefulWidget {
  static const String routeName = 'Edit task';

  EditTask({super.key});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  TextEditingController? titleController;
  TextEditingController? descriptionController;
  late Task task;
  late ListProvider listProvider;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as Task;
    titleController = TextEditingController(text: '${args.title}');
    descriptionController = TextEditingController(text: '${args.description}');
    task = Task(
        title: args.title,
        description: args.description,
        date: args.date,
        id: args.id);
    listProvider = Provider.of<ListProvider>(context);
    var provider = Provider.of<SettingsProvider>(context);
    return Scaffold(
        backgroundColor:
            provider.isDarkMode() ? MyTheme.darkBody : MyTheme.lightBody,
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.appTitle,
            style: Theme.of(context)!.textTheme.titleLarge,
          ),
          toolbarHeight: MediaQuery.of(context).size.height * 0.2,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: MediaQuery.of(context)!.size.height * 0.5,
              color: provider.isDarkMode()
                  ? MyTheme.darkBlackColor
                  : MyTheme.wightColor,
              padding: EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    AppLocalizations.of(context)!.editTask,
                    style: Theme.of(context)!.textTheme.titleLarge!.copyWith(
                          fontSize: 18,
                          color: provider.isDarkMode()
                              ? MyTheme.wightColor
                              : MyTheme.blackColor,
                        ),
                  ),
                  TextFormField(
                    controller: titleController,
                    style: TextStyle(
                        color: provider.isDarkMode()
                            ? MyTheme.wightColor
                            : MyTheme.blackColor),
                    autocorrect: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                  ),
                  TextFormField(
                    controller: descriptionController,
                    style: TextStyle(
                        color: provider.isDarkMode()
                            ? MyTheme.wightColor
                            : MyTheme.blackColor),
                    autocorrect: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                  ),
                  Text(
                    AppLocalizations.of(context)!.selectDate,
                    style: Theme.of(context)!.textTheme.titleLarge!.copyWith(
                        fontSize: 18,
                        color: provider.isDarkMode()
                            ? MyTheme.wightColor
                            : MyTheme.blackColor),
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    '${DateFormat('dd / MM / yyyy').format(selectedDate)}',
                    style: Theme.of(context)!.textTheme.titleLarge!.copyWith(
                        fontSize: 15,
                        color: provider.isDarkMode()
                            ? MyTheme.grayColor
                            : MyTheme.deepGrayColor,
                        fontWeight: FontWeight.w300),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: MyTheme.primaryColor),
                    onPressed: () {
                      updateTask(task).timeout(Duration(milliseconds: 100),
                          onTimeout: () {
                        Navigator.pop(context);
                        listProvider.getAllTasksFromFireStore();
                        DialogUtils.showMessage(context,
                            message: AppLocalizations.of(context)!
                                .updateSuccessfully);
                      });
                    },
                    child: Text(
                      AppLocalizations.of(context)!.saveChange,
                      style: Theme.of(context)!
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 18),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> updateTask(Task task) {
    return FirebaseUtils.getTaskCollection().doc(task.id).update({
      'title': titleController!.value.text,
      'description': descriptionController!.value.text,
    });
  }
}
