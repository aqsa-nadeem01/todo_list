
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/model/task.dart';

class SharedPrefService {
  static SharedPreferences? _preferences;

  static Future<void> initializeSharedPref() async {
    _preferences = await SharedPreferences.getInstance();
    if (_preferences == null) {
      print("SharedPreferences initialization failed");
    } else {
      print("SharedPreferences initialized successfully");
    }
  }


  static List<Task> readTask() {
    List<String>? storedTasks = _preferences?.getStringList('storedData');
    if (storedTasks != null) {
      return storedTasks
          .map((taskString) => Task.fromJson(jsonDecode(taskString)))
          .toList();
    }
    return [];
  }

  static void saveTasks(List<Task> tasks) {
    List<String> taskList =
    tasks.map((task) => jsonEncode(task.toJson())).toList();
    _preferences?.setStringList('storedData', taskList);
  }
}
