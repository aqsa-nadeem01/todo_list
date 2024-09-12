import 'package:flutter/material.dart';

enum TaskCategory{
  personal,
  work,
  shopping,
  fitness,
  finance,
  health,
  education,
  travel,
}

class Category{
  Category(this.title, this.icon);
  final String title;
  final IconData icon;
}