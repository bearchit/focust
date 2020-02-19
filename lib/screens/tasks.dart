import 'package:flutter/material.dart';
import 'package:focust/entities/task.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<Task> _tasks = [
    Task("Task #1"),
    Task("Task #2"),
    Task("Task #3"),
    Task("Task #4"),
    Task("Task #5"),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _tasks.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(_tasks[index].content),
        );
      },
    );
  }
}
