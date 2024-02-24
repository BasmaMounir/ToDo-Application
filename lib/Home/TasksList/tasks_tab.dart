import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:to_do_application/Home/TasksList/item_task_list.dart';
import 'package:to_do_application/my_theme.dart';

class TasksTab extends StatelessWidget {
  TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            child: EasyDateTimeLine(
              initialDate: DateTime.now(),
              onDateChange: (selectedDate) {
                //`selectedDate` the new date selected.
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
                itemCount: 30,
                itemBuilder: (context, index) {
                  return ItemTaskList();
                }))
      ],
    );
  }
}
