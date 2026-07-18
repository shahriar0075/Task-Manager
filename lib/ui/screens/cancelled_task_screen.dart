import 'package:flutter/material.dart';
import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
import '../../data/service/network_clint.dart';
import '../../data/utils/urls.dart';
import '../widgets/Task_Count.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool _cancelledTaskInProgress = false;
  List<TaskModel> _cancelledTaskList = [];
  @override
  void initState() {
    _getCancelledAllTaskList();
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
                    final task = _cancelledTaskList[index];
                    return TaskCard(
                      title: task.title,
                      taskStatus: TaskStatus.cancelled,
                      taskModel: _cancelledTaskList[index],
                      refreshList: _getCancelledAllTaskList,
                    );
                  }, separatorBuilder: (context,index)=>const SizedBox(height: 1), itemCount: _cancelledTaskList.length),
            ],
          ),
        )

    );
  }
  Future<void> _getCancelledAllTaskList() async {
    _cancelledTaskInProgress = true;
    if (mounted) setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(url: Urls.taskListUrl('Cancelled'));
    if(response.isSuccess){
      _cancelledTaskInProgress = false;
      TaskListModel taskListModel =TaskListModel.fromJson((response.data ?? {}));
      _cancelledTaskList = taskListModel.taskList;
    }
    else{
      if (mounted) showSnackBarMessage(context, response.errorMessage, true);
    }
    _cancelledTaskInProgress = false;
    if (mounted) setState(() {});
  }
}