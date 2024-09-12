
import 'package:flutter/material.dart';
import 'package:todo_list/model/category.dart';

Map<TaskCategory, Category> categories = {
  TaskCategory.personal: Category('Personal', Icons.person),
  TaskCategory.work: Category('Work', Icons.work),
  TaskCategory.shopping: Category('Shopping', Icons.shopping_cart),
  TaskCategory.fitness: Category('Fitness', Icons.fitness_center),
  TaskCategory.finance: Category('Finance', Icons.attach_money),
  TaskCategory.health: Category('Health', Icons.health_and_safety),
  TaskCategory.education: Category('Education', Icons.school),
  TaskCategory.travel: Category('Travel', Icons.flight),
};
