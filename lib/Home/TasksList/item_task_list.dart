import 'package:flutter/material.dart';
import 'package:to_do_application/ModelClass/task.dart';
import 'package:to_do_application/my_theme.dart';

class ItemTaskList extends StatelessWidget {
  Task tasks;

  ItemTaskList({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: MyTheme.wightColor, borderRadius: BorderRadius.circular(25)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 5,
            height: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(
                color: MyTheme.primaryColor,
                borderRadius: BorderRadius.circular(25)),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tasks.title ?? '',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: MyTheme.primaryColor),
              ),
              Text(
                tasks.description ?? '',
                style: TextStyle(fontSize: 18),
              ),
            ],
          )),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
                color: MyTheme.primaryColor,
                borderRadius: BorderRadius.circular(16)),
            child: Icon(
              Icons.check,
              color: MyTheme.wightColor,
              size: 35,
            ),
          )
        ],
      ),
    );
  }
}
