import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_application/my_theme.dart';

class TaskListBottomSheet extends StatefulWidget {
  const TaskListBottomSheet({super.key});

  @override
  State<TaskListBottomSheet> createState() => _TaskListBottomSheetState();
}

class _TaskListBottomSheetState extends State<TaskListBottomSheet> {
  DateTime selectedDate = DateTime.now();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final TextEditingController? titleController = TextEditingController();
  final TextEditingController? descriptionontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      child: Container(
        margin: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              textAlign: TextAlign.center,
              'Add new Task',
              style: Theme.of(context)!
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 18, color: MyTheme.blackColor),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: titleController,
              validator: (value) => value!.isEmpty ? 'Title is empty' : null,
              decoration: InputDecoration(
                  hintText: 'enter your task title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: descriptionontroller,
              validator: (value) =>
                  value!.isEmpty ? 'Description is empty' : null,
              decoration: InputDecoration(
                  hintText: 'enter your task description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
            ),
            SizedBox(height: 20),
            Text(
              'Select time',
              style: Theme.of(context)!
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 18, color: MyTheme.blackColor),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                return showCalender();
              },
              child: Text(
                textAlign: TextAlign.center,
                '${DateFormat('dd / MM / yyyy').format(selectedDate)}',
                style: Theme.of(context)!.textTheme.titleLarge!.copyWith(
                    fontSize: 15,
                    color: MyTheme.deepGrayColor,
                    fontWeight: FontWeight.w300),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (globalKey.currentState!.validate()) {
                  titleController!.clear();
                  descriptionontroller!.clear();
                }
              },
              child: Text(
                'Add Task',
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
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (chosenDate != null) {
      setState(() {
        selectedDate = chosenDate;
      });
    }
  }
}
