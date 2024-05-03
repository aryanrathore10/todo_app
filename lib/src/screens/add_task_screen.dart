import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app/src/database/database_helper.dart';
import 'package:todo_app/src/database/models/task.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
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
                          DatabaseHelper.addTask(newTask).then((value){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Task Added!!!')));
                            Navigator.pop(context);
                          }).catchError((error){
                            log(error);
                          });
                        }
                      },
                      child: const Text('Add'))
                ],
              ))
        ],
      ),
    );
  }
}
