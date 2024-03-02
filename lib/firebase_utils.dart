import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_application/ModelClass/task.dart';

class FirebaseUtils {

  static CollectionReference<Task> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.fromJson(snapshot.data()!),
            toFirestore: (task, options) => task.toJson());
  }

  static Future<void> AddTaskToFireStore(Task task) {
    var taskCollection = getTaskCollection();
    DocumentReference<Task> taskDoc = taskCollection.doc();
    task.id = taskDoc.id;
    return taskDoc.set(task);
  }
}
