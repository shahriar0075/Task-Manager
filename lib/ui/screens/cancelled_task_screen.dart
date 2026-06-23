import 'package:flutter/material.dart';
import '../widgets/task_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemBuilder: (context,index){
              return const TaskCard(title: 'Progress', taskStatus: TaskStatus.cancelled,);
            }, separatorBuilder: (context,index)=>const SizedBox(height: 0), itemCount: 6)

    );
  }
}