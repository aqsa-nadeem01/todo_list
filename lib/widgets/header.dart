import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/utils/size_config.dart';

class Header extends StatelessWidget{
  const Header({super.key});
  @override
  Widget build(BuildContext context) {
    DateTime now=DateTime.now();
    String todayDate=DateFormat('MMM d, yyyy').format(now);
    return Container(
        height: SizeConfig.screenHeight*0.32,
        width: double.infinity,
        color: Colors.yellow,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('My Todo List', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400,fontStyle:FontStyle.italic ),),

          Text(todayDate, style: const TextStyle(fontSize: 16,))

        ],
    ),
    );
  }
}