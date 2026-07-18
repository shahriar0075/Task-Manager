import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_management/data/service/network_clint.dart';
import 'package:task_management/ui/widgets/snack_bar_message.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/data/utils/urls.dart';

enum TaskStatus {
  newStatus,
  progress,
  completed,
  cancelled
}

class TaskCard extends StatefulWidget {
  final String title;
  const TaskCard({
    super.key,
    required this.title,
    required this.taskStatus,
    required this.taskModel,
    required this.refreshList,
  });
  final TaskStatus taskStatus;
  final TaskModel taskModel;
  final VoidCallback refreshList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _inProgress = false;
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
              Text(widget.taskModel.title,style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),),
              Text(widget.taskModel.description),
              const SizedBox(height: 8,),
              Text('Date: ${DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.parse(widget.taskModel.createDate.toString()))}'),
              Row(
                children: [
                  Chip(label: Text(widget.taskModel.status,style: TextStyle(color: Colors.white),),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      backgroundColor: _getStatusChipColor(),
                      side: BorderSide.none
                  ),
                  const Spacer(),
                  Visibility(
                    visible: _inProgress == false,
                    replacement: const Center(child: CircularProgressIndicator()),
                    child: Row(
                      children: [
                        IconButton(onPressed: _showUpdateStatusDialog, icon: const Icon(Icons.edit, color: Colors.green,)),
                        IconButton(onPressed: _deleteTask, icon: const Icon(Icons.delete, color: Colors.red,))
                      ],
                    ),
                  ),

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
    switch (widget.taskStatus){
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
  void _showUpdateStatusDialog(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Update Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: (){
                _popDialog();
                if(isSelected('New')) return;
                _changeTaskStatus('New');
              },
              title: const Text('New'),
              trailing: isSelected('New') ? const Icon(Icons.check, color: Colors.green,) : null,
            ),
            ListTile(
              onTap: (){
                _popDialog();
                if(isSelected('progress')) return;
                _changeTaskStatus('progress');
              },
              title: const Text('Progress'),
              trailing: isSelected('progress') ? const Icon(Icons.check, color: Colors.green,) : null,
            ),
            ListTile(
              onTap: (){
                _popDialog();
                if(isSelected('completed')) return;
                _changeTaskStatus('completed');
              },
              title: const Text('Completed'),
              trailing: isSelected('completed') ? const Icon(Icons.check, color: Colors.green,) : null,
            ),
            ListTile(
              onTap: (){
                _popDialog();
                if(isSelected('cancelled')) return;
                _changeTaskStatus('cancelled');
              },
              title: const Text('Cancelled'),
              trailing: isSelected('cancelled') ? const Icon(Icons.check, color: Colors.green,) : null,
            ),
          ],
        ),
      );
    });
  }

  void _popDialog(){
    Navigator.pop(context);
  }
  bool isSelected(String status) => widget.taskModel.status == status;

  Future<void> _changeTaskStatus(String status) async {
    _inProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(url: Urls.updateTaskStatusUrl(widget.taskModel.id, status));
    if(response.isSuccess){
      widget.refreshList();
    }
    else{
      showSnackBarMessage(context, response.errorMessage, true);
      setState(() {});
    }
    _inProgress = false;

  }
  Future<void> _deleteTask() async {
    _inProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(url: Urls.deleteTaskUrl(widget.taskModel.id));
    if(response.isSuccess){
      widget.refreshList();
    }
    else{
      showSnackBarMessage(context, response.errorMessage, true);
      setState(() {});
    }
    _inProgress = false;
  }
}