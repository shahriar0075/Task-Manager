import 'package:flutter/material.dart';
import '../widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemBuilder: (context,index){
              return const TaskCard(title: 'Progress', taskStatus: TaskStatus.completed,);
            }, separatorBuilder: (context,index)=>const SizedBox(height: 0), itemCount: 6)

    );
  }
}