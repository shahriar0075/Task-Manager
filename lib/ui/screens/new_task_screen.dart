import 'package:flutter/material.dart';
import 'package:task_management/ui/screens/add_new_task_screen.dart';

import '../widgets/summary_card.dart';
import '../widgets/task_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildSingleChildScrollView(),
            ListView.separated(
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  return const TaskCard(title: 'New',taskStatus: TaskStatus.newStatus,);
            }, separatorBuilder: (context,index)=>const SizedBox(height: 0), itemCount: 6)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: onTapNewTask, child: const Icon(Icons.add),),
    );
  }

void onTapNewTask(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddNewTaskScreen()));
}
  Widget buildSingleChildScrollView() {
    return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SummaryCard(title: 'New',count: 12),
                SummaryCard(title: 'Completed',count: 12),
                SummaryCard(title: 'Cancelled',count: 12),
                SummaryCard(title: 'Progress',count: 12),
              ],
            ),
          ),
        );
  }
}