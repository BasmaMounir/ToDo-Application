import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_application/Home/TasksList/item_task_list.dart';
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
    listProvider.getAllTasksFromFireStore();
    var provider = Provider.of<SettingsProvider>(context);
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            child: EasyDateTimeLine(
              locale: provider.language,
              initialDate: listProvider.selectedDate,
              onDateChange: (selectedDate) {
                listProvider.cahngeDate(selectedDate);
              },
              activeColor: MyTheme.primaryColor,
              dayProps: const EasyDayProps(
                borderColor: Colors.black,
                todayHighlightStyle: TodayHighlightStyle.withBackground,
                todayHighlightColor: Color(0x5c5d9cec),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: ListView.builder(
              itemCount: listProvider.tasksList.length,
              itemBuilder: (context, index) {
                return ItemTaskList(
                  tasks: listProvider.tasksList[index],
                );
              }),
        )
      ],
    );
  }
}
