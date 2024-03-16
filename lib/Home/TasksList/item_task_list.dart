import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do_application/ModelClass/task.dart';
import 'package:to_do_application/Providers/authProviders.dart';
import 'package:to_do_application/Providers/list_provider.dart';
import 'package:to_do_application/Providers/settings-provider.dart';
import 'package:to_do_application/firebase_utils.dart';
import 'package:to_do_application/my_theme.dart';

class ItemTaskList extends StatelessWidget {
  Task tasks;

  ItemTaskList({super.key, required this.tasks});

  //bool pressed = false;
  //late var listProvider;

  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    var provider = Provider.of<SettingsProvider>(context);
    var authProvider = Provider.of<AuthProviders>(context);

    return Container(
      margin: const EdgeInsets.all(8),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.3,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(20),
              onPressed: (context) {
                FirebaseUtils.deleteTaskFromFireStore(
                        tasks, authProvider.currentUser!.id!)
                    .then((value) {
                  // DialogUtils.showMessage(context,
                  //     message: 'Task Deleted Successfully');
                  listProvider
                      .getAllTasksFromFireStore(authProvider.currentUser!.id!);
                }).timeout(const Duration(milliseconds: 500), onTimeout: () {
                  // DialogUtils.showMessage(context,
                  //     message: 'Task Deleted Successfully');
                  listProvider
                      .getAllTasksFromFireStore(authProvider.currentUser!.id!);
                });
              },
              backgroundColor: MyTheme.redColor,
              foregroundColor: MyTheme.wightColor,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: provider.isDarkMode()
                  ? MyTheme.darkBlackColor
                  : MyTheme.wightColor,
              borderRadius: BorderRadius.circular(25)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 5,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                    color: tasks.isDone == true
                        ? MyTheme.greenColor
                        : MyTheme.primaryColor,
                    borderRadius: BorderRadius.circular(25)),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tasks.title ?? '',
                    style: tasks.isDone == true
                        ? Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: MyTheme.greenColor)
                        : Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: MyTheme.primaryColor),
                  ),
                  Text(
                    tasks.isDone == true ? '' : tasks.description ?? '',
                    style: TextStyle(
                        fontSize: 18,
                        color: provider.isDarkMode()
                            ? MyTheme.wightColor
                            : MyTheme.blackColor),
                  ),
                ],
              )),
              tasks.isDone == true
                  ? Text('${AppLocalizations.of(context)!.done}!',
                      style: tasks.isDone == true
                          ? Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: MyTheme.greenColor)
                          : null)
                  : InkWell(
                      onTap: () {
                        updateTask(tasks, context)
                            .then((value) =>
                                listProvider.getAllTasksFromFireStore(
                                    authProvider.currentUser!.id!))
                            .timeout(const Duration(milliseconds: 500),
                                onTimeout: () {
                          listProvider.getAllTasksFromFireStore(
                              authProvider.currentUser!.id!);
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                            color: MyTheme.primaryColor,
                            borderRadius: BorderRadius.circular(16)),
                        child: Icon(
                          Icons.check,
                          color: MyTheme.wightColor,
                          size: 35,
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateTask(Task task, BuildContext context) {
    var authProvider = Provider.of<AuthProviders>(context, listen: false);

    return FirebaseUtils.getTaskCollection(authProvider.currentUser!.id!)
        .doc(task.id)
        .update({'isDone': true});
  }
}
