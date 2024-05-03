


import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app/src/database/database_helper.dart';
import 'package:todo_app/src/database/models/task.dart';

class TaskDetailsScreen extends StatelessWidget {
  final Task task;
  const TaskDetailsScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final titleController = TextEditingController(text: task.title);
    final descriptionController = TextEditingController(text: task.description);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Details"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter a task title";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Title',
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter a task description";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Description',
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final Task newTask = Task(
                              title: titleController.text.trim(),
                              description: descriptionController.text.trim(),
                              isComplete: false,
                              createdAt: DateTime.now());
                          DatabaseHelper.editTask(task.id!, task).catchError((e){
                            log(e.toString());
                          });
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Save')),
                      const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade300
                    ),
                      onPressed: () {
                        log(task.id.toString());
                        DatabaseHelper.deleteTask(task).then((value){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Task Deleted!!!')));
                          Navigator.pop(context);
                        }).catchError((e){
                          log(e.toString());
                        });
                      },
                      child: const Text('Delete'))
                ],
              ))
        ],
      ),
    );
  }
}