import 'package:flutter/material.dart';
import 'package:task_management/ui/widgets/Task_Count.dart';
import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
import '../../data/service/network_clint.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _getCompletedTaskInProgress = false;
  List<TaskModel> _completedTaskList = [];
  @override
  void initState() {
    super.initState();
    _getCompletedAllTaskList();
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
                    final task = _completedTaskList[index];
                    return TaskCard(
                      title: task.title,
                      taskStatus: TaskStatus.completed,
                      taskModel: _completedTaskList[index],
                      refreshList: _getCompletedAllTaskList,
                    );
                  }, separatorBuilder: (context,index)=>const SizedBox(height: 1), itemCount: _completedTaskList.length),
            ],
          ),
        ),

    );
  }
  Future<void> _getCompletedAllTaskList() async {
    _getCompletedTaskInProgress = true;
    if (mounted) setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(url: Urls.taskListUrl('Completed'));
    if(response.isSuccess){
      _getCompletedTaskInProgress = false;
      TaskListModel taskListModel =TaskListModel.fromJson((response.data ?? {}));
      _completedTaskList = taskListModel.taskList;
    }
    else{
      if (mounted) showSnackBarMessage(context, response.errorMessage, true);
    }
    _getCompletedTaskInProgress = false;
    if (mounted) setState(() {});
  }
}