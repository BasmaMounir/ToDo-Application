import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do_application/ModelClass/task.dart';
import 'package:to_do_application/Providers/list_provider.dart';
import 'package:to_do_application/Providers/settings-provider.dart';
import 'package:to_do_application/firebase_utils.dart';
import 'package:to_do_application/my_theme.dart';

class ItemTaskList extends StatefulWidget {
  Task tasks;

  ItemTaskList({super.key, required this.tasks});

  @override
  State<ItemTaskList> createState() => _ItemTaskListState();
}

class _ItemTaskListState extends State<ItemTaskList> {
  //bool pressed = false;
  late var listProvider;

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);
    var provider = Provider.of<SettingsProvider>(context);
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
                FirebaseUtils.deleteTaskFromFireStore(widget.tasks)
                    .timeout(const Duration(milliseconds: 500), onTimeout: () {
                  listProvider.getAllTasksFromFireStore();
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
                    color: widget.tasks.isDone == true
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
                    widget.tasks.title ?? '',
                    style: widget.tasks.isDone == true
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
                    widget.tasks.isDone == true
                        ? ''
                        : widget.tasks.description ?? '',
                    style: TextStyle(
                        fontSize: 18,
                        color: provider.isDarkMode()
                            ? MyTheme.wightColor
                            : MyTheme.blackColor),
                  ),
                ],
              )),
              widget.tasks.isDone == true
                  ? Text('${AppLocalizations.of(context)!.done}!',
                      style: widget.tasks.isDone == true
                          ? Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: MyTheme.greenColor)
                          : null)
                  : InkWell(
                      onTap: () {
                        updateTask(widget.tasks).timeout(
                            const Duration(milliseconds: 500), onTimeout: () {
                          listProvider.getAllTasksFromFireStore();
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

  Future<void> updateTask(Task task) {
    return FirebaseUtils.getTaskCollection()
        .doc(task.id)
        .update({'isDone': true});
  }
}
