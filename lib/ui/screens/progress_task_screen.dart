import 'package:flutter/material.dart';
import 'package:task_management/ui/widgets/Task_Count.dart';
import 'package:task_management/data/models/task_list_model.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/data/service/network_clint.dart';
import 'package:task_management/data/utils/urls.dart';
import 'package:task_management/ui/widgets/snack_bar_message.dart';
import 'package:task_management/ui/widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _getProgressTaskInProgress = false;
  List<TaskModel> _progressTaskList = [];
  @override
  void initState() {
    _getProgressAllTaskList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TaskCount(),
            ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      itemBuilder: (context,index){
                        final task = _progressTaskList[index];
                        return TaskCard(
                          title: task.title,
                          taskStatus: TaskStatus.progress,
                          taskModel: _progressTaskList[index],
                          refreshList: _getProgressAllTaskList,
                        );
                      }, separatorBuilder: (context,index)=>const SizedBox(height: 1), itemCount: _progressTaskList.length),
          ],
        ),
      ));
  }
  Future<void> _getProgressAllTaskList() async {
    _getProgressTaskInProgress = true;
    if (mounted) setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(url: Urls.taskListUrl('progress'));
    if(response.isSuccess){
      _getProgressTaskInProgress = false;
      TaskListModel taskListModel =TaskListModel.fromJson((response.data ?? {}));
      _progressTaskList = taskListModel.taskList;
    }
    else{
      if (mounted) showSnackBarMessage(context, response.errorMessage, true);
    }
    _getProgressTaskInProgress = false;
    if (mounted) setState(() {});
  }
}

