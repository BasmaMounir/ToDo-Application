import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_application/ModelClass/task.dart';
import 'package:to_do_application/firebase_utils.dart';

class ListProvider extends ChangeNotifier {
  List<Task> tasksList = [];
  DateTime selectedDate = DateTime.now();

  void getAllTasksFromFireStore() async {
    QuerySnapshot<Task> snapshot =
        await FirebaseUtils.getTaskCollection().get();
    tasksList = snapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    //filter tasks
    tasksList = tasksList.where((task) {
      if (selectedDate.day == task.date!.day &&
          selectedDate.month == task.date!.month &&
          selectedDate.year == task.date!.year) return true;
      return false;
    }).toList();

    // sorting tasks
    tasksList.sort(
      (task1, task2) {
        return task1.date!.compareTo(task2.date!);
      },
    );
    notifyListeners();
  }

  void cahngeDate(DateTime newDate) {
    selectedDate = newDate;
    getAllTasksFromFireStore();
  }
}
