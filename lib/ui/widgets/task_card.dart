import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/task_model.dart';

enum TaskStatus {
  newStatus,
  progress,
  completed,
  cancelled
}

class TaskCard extends StatelessWidget {
  final String title;
  const TaskCard({
    super.key,
    required this.title,
    required this.taskStatus,
    required this.taskModel,
  });
  final TaskStatus taskStatus;
  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(taskModel.title,style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),),
              Text(taskModel.description),
              const SizedBox(height: 8,),
              Text('Date: ${DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.parse(taskModel.createDate.toString()))}'),
              Row(
                children: [
                  Chip(label: Text(taskModel.status,style: TextStyle(color: Colors.white),),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      backgroundColor: _getStatusChipColor(),
                      side: BorderSide.none
                  ),
                  const Spacer(

                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.edit, color: Colors.green,)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.delete, color: Colors.red,))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  Color _getStatusChipColor(){
    late Color color;
    switch (taskStatus){
      case TaskStatus.newStatus:
        color= Colors.blue;
      case TaskStatus.progress:
        color= Colors.purple;
      case TaskStatus.completed:
        color= Colors.green;
      case TaskStatus.cancelled:
        color= Colors.red;
    }
    return color;
  }
}