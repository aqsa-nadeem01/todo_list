

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/model/task.dart';
import 'package:todo_list/services/shared_pref.dart';
import 'package:todo_list/utils/size_config.dart';
import 'package:todo_list/widgets/header.dart';
import 'package:todo_list/widgets/list.dart';
import 'package:todo_list/widgets/new_task.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> _registratedTask = [];
  late SharedPreferences sp;

  @override
  void initState() {
    super.initState();

    _loadTasks();
  }

  Future<void> _loadTasks() async {
    await SharedPrefService.initializeSharedPref();
    setState(() {
      _registratedTask = SharedPrefService.readTask(); // Read the saved tasks
    });
  }

  void _saveTasks() {
    SharedPrefService.saveTasks(_registratedTask); // Save tasks using the service
  }


  void _openAddTaskLayout() async {
    final newTask = await showModalBottomSheet(
        context: context, builder: (ctx) => const NewTask());

    if (newTask == null) {
      return;
    }

    setState(() {
      _registratedTask.add(newTask);
    });

    _saveTasks(); // Save tasks after adding a new one
  }

  void _onRemoveTask(Task task) {
    final taskIndex = _registratedTask.indexOf(task);
    setState(() {
      _registratedTask.remove(task); // Remove the task
    });

    _saveTasks();

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Task removed'),
      duration: const Duration(seconds: 5),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registratedTask.insert(taskIndex, task); // Restore the task if undone
            });
            _saveTasks();
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Stack(
          children: [
            const Header(),
            Positioned(
              top: SizeConfig.screenHeight * 0.25,
              left: 20,
              right: 20,
              child: ToDoList(
                  registeredTasks: _registratedTask, onRemoveTask: _onRemoveTask),
            ),
            Positioned(
                top: SizeConfig.screenHeight * 0.905,
                left: 20,
                right: 20,
                child: SizedBox(
                  height: 55,
                  child: ElevatedButton(
                      onPressed: _openAddTaskLayout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text(
                        'Add Task',
                        style: TextStyle(fontSize: 18),
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
