import 'package:flutter/material.dart';
import '../widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context,index){
                return const TaskCard(title: 'Progress', taskStatus: TaskStatus.progress,);
                }, separatorBuilder: (context,index)=>const SizedBox(height: 0), itemCount: 6)

    );
  }
}