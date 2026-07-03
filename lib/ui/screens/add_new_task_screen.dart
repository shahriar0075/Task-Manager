import 'package:flutter/material.dart';

import 'package:task_management/ui/widgets/screen_background.dart';
import '../widgets/tm_app_bar.dart';
import 'main_bottom_nave_screen.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100,),
                  Text("Add New Task",style: Theme.of(context).textTheme.titleLarge,),
                  SizedBox(height: 16,),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Task Title',),
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    maxLines: 5,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    ),
                  ),
                  ElevatedButton(onPressed: onTapAddTaskButton, child: const Text("Add Task")),
                ]
              ),
            ),
          )
      )
    );
  }
  void onTapAddTaskButton(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute( builder: (contex)=> const MainBottomNaveScreen()), (pre)=>false);
  }
}