import 'package:flutter/material.dart';
import 'package:todo_app/src/database/database_helper.dart';
import 'package:todo_app/src/database/models/task.dart';
import 'package:todo_app/src/screens/task_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    DatabaseHelper.getAllTasks().then((value){
      setState(() {
        tasks = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ToDo'),),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index)=> ListTile(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> TaskDetailsScreen(task: tasks[index],)));
          },
        title: Text(tasks[index].title),
        subtitle: Text(tasks[index].description),
        leading: const Icon(Icons.task),
              )),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).pushNamed("add/");
      },child: const Icon(Icons.add),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
