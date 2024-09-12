import 'package:todo_list/data/category.dart';
import 'package:todo_list/model/category.dart';
import 'package:todo_list/model/task.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/services/shared_pref.dart';
import 'package:todo_list/utils/size_config.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({required this.registeredTasks, required this.onRemoveTask, super.key});
  final List<Task> registeredTasks;
  final Function(Task task) onRemoveTask;

  @override
  State<StatefulWidget> createState() {
    return _ToDoList();
  }
}

class _ToDoList extends State<ToDoList> {


  @override
  Widget build(BuildContext context) {
    Widget mainContent=const Center(
      child: Text('Ops no task found. Start adding some!'),
    );
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.grey.shade50,
          border: Border.all()

        ),
        height: SizeConfig.screenHeight * 0.64,

        child: widget.registeredTasks.isEmpty ? mainContent :
        ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: widget.registeredTasks.length,
          itemBuilder: (context, index) => Dismissible(
            key: ValueKey(widget.registeredTasks[index]),
            onDismissed: (direction){
              widget.onRemoveTask(widget.registeredTasks[index]);
            },
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(12),
                height: 75,
                color: widget.registeredTasks[index].isDone ? Colors.grey.shade400 : Colors.grey.shade200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(widget.registeredTasks[index].category),
                        const SizedBox(width: 10),
                        Text(
                          widget.registeredTasks[index].title,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            decoration: widget.registeredTasks[index].isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: widget.registeredTasks[index].isDone ? Colors.black54 : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Checkbox(
                      value: widget.registeredTasks[index].isDone,
                      onChanged: (bool? newValue) {
                        setState(() {
                          widget.registeredTasks[index].toggleValue();
                        });
                        SharedPrefService.saveTasks(widget.registeredTasks);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
