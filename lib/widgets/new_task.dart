import 'package:todo_list/data/category.dart';
import 'package:todo_list/model/category.dart';
import 'package:todo_list/model/task.dart';
import 'package:flutter/material.dart';

class NewTask extends StatefulWidget{
 const NewTask({super.key});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {

  void _createTask(){
    if(_formkey.currentState!.validate()){
      _formkey.currentState!.save();
      Navigator.of(context).pop(Task(title: _title!, category: _category!.icon));
    }

  }

  final _formkey=GlobalKey<FormState>();
  String? _title;
  Category? _category;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add New Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
            key: _formkey,
            child: Column(
              
          children: [
            TextFormField(

              maxLength: 30,
              validator: (value){
                if(value==null || value.trim().isEmpty){
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (newValue){
                _title=newValue;
              },
              decoration: const InputDecoration(
                labelText: 'What are you planning?'
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            DropdownButtonFormField(
              validator: (value){
                if(value==null){
                  return 'Please select a category';
                }
                return null;
              },
                onSaved: (newValue){
                _category=categories[newValue];
                },
              hint: const Row(
                children: [
                  Icon(Icons.category),
                  SizedBox(width: 10,),
                  Text('Select Category'),

                ],
              ),
                items:  [for (final category in categories.entries)
                  DropdownMenuItem(
                      value: category.key,
                      child: Row(

                    children: [
                      Icon(category.value.icon),
                      const SizedBox(width: 10,),
                      Text(category.value.title),

                    ],
                  ),
                  )
                  
                  ]

                  , onChanged: (value){
                _category=categories[value];
            }
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          _formkey.currentState!.reset();

                        }, child: const Text('Rest'))),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: ElevatedButton(
                      onPressed: _createTask,
                        child: const Text('Create')))
              ],
            )
          ],
        ),
        ),
      ),
    );
  }
}