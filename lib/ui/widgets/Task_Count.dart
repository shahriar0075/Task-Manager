import 'package:flutter/material.dart';
import 'package:task_management/ui/widgets/snack_bar_message.dart';
import 'package:task_management/ui/widgets/summary_card.dart';
import '../../data/models/task_status_count.dart';
import '../../data/models/task_status_list_model.dart';
import '../../data/service/network_clint.dart';
import '../../data/utils/urls.dart';

class TaskCount extends StatefulWidget {
  const TaskCount({super.key});

  @override
  State<TaskCount> createState() => _TaskCountState();
}

class _TaskCountState extends State<TaskCount> {
  bool _getStatusCountInProgress = false;
  List<TaskStatusCountModel> _taskStatusCountList = [];
  @override
  void initState() {
    _getAllTaskStatusCount();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 100,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _taskStatusCountList.length,
              itemBuilder: (context, index){
                return SummaryCard(title: _taskStatusCountList[index].status, count: _taskStatusCountList[index].count);
              }),
        ),
      ),
    );
  }
  Future<void> _getAllTaskStatusCount() async {
    _getStatusCountInProgress =true;
    setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(url: Urls.taskStatusCountUrl);
    if(response.isSuccess){
      _getStatusCountInProgress = false;
      TaskStatusCountListModel taskStatusCountListModel =TaskStatusCountListModel.fromJson((response.data ?? {}));
      _taskStatusCountList = taskStatusCountListModel.statusCountList;
    }
    else{
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getStatusCountInProgress = false;
    setState(() {});
  }
}
