import 'package:flutter/material.dart';
import 'package:task_management/data/models/task_list_model.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/data/service/network_clint.dart';
import 'package:task_management/ui/screens/add_new_task_screen.dart';
import 'package:task_management/ui/widgets/Task_Count.dart';
import 'package:task_management/ui/widgets/center_circular_process_indicator.dart';
import 'package:task_management/ui/widgets/snack_bar_message.dart';
import '../../data/utils/urls.dart';
import '../widgets/task_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getNewTaskInProgress = false;
  List<TaskModel> _newtaskList = [];

  @override
  void initState() {
    _getNewAllTaskList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TaskCount(),
            Visibility(
              visible: !_getNewTaskInProgress,
              replacement: const CenterCircularProgressIndicator(),
              child: Visibility(
                visible: !_getNewTaskInProgress,
                child: ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      final task = _newtaskList[index];
                      return TaskCard(
                        title: task.title,
                        taskStatus: TaskStatus.newStatus,
                        taskModel: _newtaskList[index],
                        refreshList: _getNewAllTaskList,
                      );
                }, separatorBuilder: (context,index)=>const SizedBox(height: 1), itemCount: _newtaskList.length),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: onTapNewTask, child: const Icon(Icons.add),),
    );
  }

void onTapNewTask(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddNewTaskScreen()));
}

  Future<void> _getNewAllTaskList() async {
    _getNewTaskInProgress =true;
    if (mounted) setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(url: Urls.taskListUrl('New'));
    if(response.isSuccess){
      _getNewTaskInProgress = false;
      TaskListModel taskListModel =TaskListModel.fromJson((response.data ?? {}));
      _newtaskList = taskListModel.taskList;
    }
    else{
      if (mounted) showSnackBarMessage(context, response.errorMessage, true);
    }
    _getNewTaskInProgress = false;
    if (mounted) setState(() {});
  }
}