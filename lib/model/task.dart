import 'package:flutter/cupertino.dart';

class Task {
   Task({
    required this.title,
    required this.category,
    this.isDone = false,
  });

  final String title;
  final IconData category;
  bool isDone;

  void toggleValue() {
    isDone = !isDone;
  }

   factory Task.fromJson(Map<String, dynamic> json) => Task(
     title: json["title"],
     category: IconData(json['category'], fontFamily: 'MaterialIcons'),
     isDone: json["isDone"],
   );

   Map<String, dynamic> toJson() => {
     "title": title,
     "category": category.codePoint,
     "isDone": isDone,
   };
}
