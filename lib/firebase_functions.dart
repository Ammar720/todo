import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/models/task_model.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTasksCollection() =>
      FirebaseFirestore.instance.collection('tasks').withConverter<TaskModel>(
            fromFirestore: (docSnapshot, _) =>
                TaskModel.fromJson(docSnapshot.data()!),
            toFirestore: (taskModel, _) => taskModel.toJson(),
          );
  static Future<void> addTaskToFireStore(TaskModel task) {
    CollectionReference<TaskModel> taskCollection = getTasksCollection();
    DocumentReference<TaskModel> documentReference = taskCollection.doc();
    task.id = documentReference.id;
    return documentReference.set(task);
  }

  static Future<List<TaskModel>> getAllTasksFromFireStore() async {
    CollectionReference<TaskModel> taskCollection = getTasksCollection();
    QuerySnapshot<TaskModel> querySnapshot = await taskCollection.get();
    return querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  static Future<void> deleteTaskToFireStore(String taskId) async {
    CollectionReference<TaskModel> taskCollection = getTasksCollection();
    return taskCollection.doc(taskId).delete();
  }
}
