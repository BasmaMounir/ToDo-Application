import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_application/ModelClass/myUser.dart';
import 'package:to_do_application/ModelClass/task.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTaskCollection(String uID) {
    return getUserCollection()
        .doc(uID)
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.fromJson(snapshot.data()!),
            toFirestore: (task, options) => task.toJson());
  }

  static Future<void> AddTaskToFireStore(Task task, String uID) {
    var taskCollection = getTaskCollection(uID);
    DocumentReference<Task> taskDoc = taskCollection.doc();
    task.id = taskDoc.id;
    return taskDoc.set(task);
  }

  static Future<void> deleteTaskFromFireStore(Task task, String uID) {
    return getTaskCollection(uID).doc(task.id).delete();
  }

  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromFireStore(snapshot.data()),
          toFirestore: (user, options) => user.toFireStore(),
        );
  }

  static Future<void> AddUserToFireStore(MyUser myUser) {
    return getUserCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> ReadUserFromFireStore(String uID) async {
    var querySnapshot = await getUserCollection().doc(uID).get();
    return querySnapshot.data();
  }
}
