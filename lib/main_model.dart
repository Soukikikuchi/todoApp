
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/todo.dart';

class MainModel extends ChangeNotifier {
  List<Todo> todoList = [];
  String newtodoText ='';

  Future getTodoList() async {
    final snapshot = await FirebaseFirestore.instance.collection('todoList').get();
    final docs = snapshot.docs;
    final todoList = docs.map((doc) => Todo(doc)).toList();
    this.todoList = todoList;
    notifyListeners();
  }
void getTodoListRealtime() {
  final snapshots = FirebaseFirestore.instance.collection('todoList').snapshots();
  snapshots.listen((snapshot) {
    final docs = snapshot.docs;
    final todoList = docs.map((doc) => Todo(doc)).toList();
    todoList.sort((a, b)=> b.createdAt.compareTo(a.createdAt));
    this.todoList = todoList;
    notifyListeners();
  });
}

  Future add() async {
    final collection = FirebaseFirestore.instance.collection('todoList');
    await collection.add({
      'title': newtodoText,
      'createdAt' : Timestamp.now(),
    });
  }
  void reload() {
    notifyListeners();
  }
  Future deleteCheckedItems() async{
    final checkedItems = todoList.where((todo) => todo.isDone).toList();
    final reference =
    checkedItems.map((todo) => todo.documentReference).toList();


    final batch = FirebaseFirestore.instance.batch();

    reference.forEach((reference) {
      batch.delete(reference);
    });
    return batch.commit();
  }
  bool checkShouldActiveCompleteButtton(){
    final checkedItems = todoList.where((todo) => todo.isDone).toList();
    return checkedItems.length > 0;
  }
}