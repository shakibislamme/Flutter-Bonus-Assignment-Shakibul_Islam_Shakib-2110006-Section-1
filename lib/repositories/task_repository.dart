import 'package:cloud_firestore/cloud_firestore.dart';

class TaskRepository {
  final CollectionReference _taskCollection = FirebaseFirestore.instance
      .collection('tasks');

  Stream<QuerySnapshot> getTasksStream() {
    return _taskCollection.orderBy('createdAt', descending: true).snapshots();
  }

  Future<void> addTask(String title, String description) async {
    await _taskCollection.add({
      'title': title,
      'description': description,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteTask(String docId) async {
    await _taskCollection.doc(docId).delete();
  }
}
