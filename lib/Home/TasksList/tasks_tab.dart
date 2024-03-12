import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_application/Home/TasksList/edit_task.dart';
import 'package:to_do_application/Home/TasksList/item_task_list.dart';
import 'package:to_do_application/ModelClass/task.dart';
import 'package:to_do_application/Providers/list_provider.dart';
import 'package:to_do_application/Providers/settings-provider.dart';
import 'package:to_do_application/my_theme.dart';

class TasksTab extends StatefulWidget {
  TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    if (listProvider.tasksList.isEmpty) {
      listProvider.getAllTasksFromFireStore();
    }
    var provider = Provider.of<SettingsProvider>(context);
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
              child: EasyDateTimeLine(
            locale: provider.appLanguage,
            initialDate: listProvider.selectedDate,
            onDateChange: (selectedDate) {
              listProvider.cahngeDate(selectedDate);
            },
            activeColor: MyTheme.primaryColor,
            headerProps: EasyHeaderProps(
              dateFormatter: DateFormatter.monthOnly(),
            ),
            dayProps: EasyDayProps(
              height: MediaQuery.of(context)!.size.height * 0.1,
              width: MediaQuery.of(context)!.size.width * 0.2,
              dayStructure: DayStructure.dayNumDayStr,
              borderColor: provider.isDarkMode()
                  ? MyTheme.wightColor
                  : MyTheme.blackColor,
              inactiveDayStyle: DayStyle(
                dayNumStyle: TextStyle(
                  color: provider.isDarkMode()
                      ? MyTheme.wightColor
                      : MyTheme.blackColor,
                  fontSize: 18.0,
                ),
              ),
              activeDayStyle: DayStyle(
                dayNumStyle: TextStyle(
                  fontSize: 18.0,
                  color: provider.isDarkMode()
                      ? MyTheme.wightColor
                      : MyTheme.blackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )),
        ),
        Expanded(
          flex: 2,
          child: ListView.builder(
              itemCount: listProvider.tasksList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: ItemTaskList(
                    tasks: listProvider.tasksList[index],
                  ),
                  onTap: () {
                    listProvider.tasksList[index].isDone == true
                        ? print('')
                        : Navigator.pushNamed(
                            context,
                            EditTask.routeName,
                            arguments: Task(
                                id: listProvider.tasksList[index].id,
                                title: listProvider.tasksList[index].title,
                                description:
                                    listProvider.tasksList[index].description,
                                date: listProvider.tasksList[index].date,
                                isDone: listProvider.tasksList[index].isDone),
                          );
                  },
                );
              }),
        )
      ],
    );
  }
}
