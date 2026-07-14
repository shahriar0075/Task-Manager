import 'package:flutter/material.dart';
import 'package:task_management/data/service/network_clint.dart';
import 'package:task_management/ui/widgets/center_circular_process_indicator.dart';

import 'package:task_management/ui/widgets/screen_background.dart';
import 'package:task_management/ui/widgets/snack_bar_message.dart';
import '../../data/utils/urls.dart';
import '../widgets/tm_app_bar.dart';


class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _addNewTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100,),
                    Text("Add New Task",style: Theme.of(context).textTheme.titleLarge,),
                    SizedBox(height: 16,),
                    TextFormField(
                      controller: _titleController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Task Title',),
                      validator: (String? value){
                        if(value?.trim().isEmpty ?? true){
                          return 'Enter your title';
                        }
                        return null;
                      }
                    ),
                    SizedBox(height: 8,),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 5,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      ),
                        validator: (String? value){
                          if(value?.trim().isEmpty ?? true){
                            return 'Enter your title';
                          }
                          return null;
                        }
                    ),
                    Visibility(
                      visible: _addNewTaskInProgress == false,
                        replacement: const CenterCircularProgressIndicator(),
                        child: ElevatedButton(
                            onPressed: onTapAddTaskButton,
                            child: const Text("Add Task"))),
                  ]
                ),
              ),
            ),
          )
      )
    );
  }
  void onTapAddTaskButton() {
    if (_formKey.currentState!.validate()) {
      _addNewTask();
    }
  }
   Future<void> _addNewTask() async{
     _addNewTaskInProgress =true;
     setState(() {});
     Map<String,dynamic> requestbody ={
       "title": _titleController.text.trim(),
       "description": _descriptionController.text.trim(),
       "statue": "New"

     };
     final NetworkResponse response =
        await NetworkClient.postRequest(url: Urls.createTaskUrl,
        body: requestbody);
     _addNewTaskInProgress = false;
     setState(() {});
     if(response.isSuccess){
       _clearTextFields();
       showSnackBarMessage(context, "New task added successfully");
     }
     else{
       showSnackBarMessage(context, response.errorMessage);
     }
   }

  void _clearTextFields(){
    _titleController.clear();
    _descriptionController.clear();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}