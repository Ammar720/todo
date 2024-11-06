import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/models/user_model.dart';

class FirebaseFunctions {
  static CollectionReference<UserModel> getUsersCollection() =>
      FirebaseFirestore.instance.collection('users').withConverter<UserModel>(
            fromFirestore: (docSnapshot, _) =>
                UserModel.fromJson(docSnapshot.data()!),
            toFirestore: (uesUserModel, _) => uesUserModel.toJson(),
          );
  static CollectionReference<TaskModel> getTasksCollection(String userId) =>
      getUsersCollection()
          .doc(userId)
          .collection('tasks')
          .withConverter<TaskModel>(
            fromFirestore: (docSnapshot, _) =>
                TaskModel.fromJson(docSnapshot.data()!),
            toFirestore: (taskModel, _) => taskModel.toJson(),
          );
  static Future<void> addTaskToFireStore(TaskModel task, String userId) {
    CollectionReference<TaskModel> taskCollection = getTasksCollection(userId);
    DocumentReference<TaskModel> documentReference = taskCollection.doc();
    task.id = documentReference.id;
    return documentReference.set(task);
  }

  static Future<List<TaskModel>> getAllTasksFromFireStore(String userId) async {
    CollectionReference<TaskModel> taskCollection = getTasksCollection(userId);
    QuerySnapshot<TaskModel> querySnapshot = await taskCollection.get();
    return querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  static Future<void> deleteTaskToFireStore(String taskId ,String userId) async {
    CollectionReference<TaskModel> taskCollection = getTasksCollection(userId);
    return taskCollection.doc(taskId).delete();
  }

  static Future<void> updateTaskStateInFireStore(
      String taskId, bool taskIsDone ,String userId) {
    CollectionReference<TaskModel> taskCollection = getTasksCollection( userId);
    return taskCollection.doc(taskId).update({'isDone': taskIsDone});
  }

  static Future<void> updateTaskDataInFireStore(TaskModel task , String userId) {
    CollectionReference<TaskModel> taskCollection = getTasksCollection( userId);
    return taskCollection.doc(task.id).update({
      'title': task.title,
      'description': task.description,
      'date': Timestamp.fromDate(task.date),
    });
  }

  static Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    UserCredential credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    UserModel user = UserModel(
      id: credential.user!.uid,
      name: name,
      email: email,
    );
    CollectionReference<UserModel> userCollection = getUsersCollection();
    userCollection.doc(user.id).set(user);
    return user;
  }

  static Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    UserCredential credential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    CollectionReference<UserModel> userCollection = getUsersCollection();
    DocumentSnapshot<UserModel> docSnapshot =
        await userCollection.doc(credential.user!.uid).get();
    return docSnapshot.data()!;
  }

  static Future<void> logout() => FirebaseAuth.instance.signOut();
}
