import 'package:flutter/material.dart';
import 'package:task_management/ui/screens/completed_task_screen.dart';
import 'package:task_management/ui/screens/new_task_screen.dart';
import 'package:task_management/ui/screens/progress_task_screen.dart';
import '../widgets/tm_app_bar.dart';
import 'cancelled_task_screen.dart';

class MainBottomNaveScreen extends StatefulWidget {
  const MainBottomNaveScreen({super.key});

  @override
  State<MainBottomNaveScreen> createState() => _MainBottomNaveScreenState();
}

class _MainBottomNaveScreenState extends State<MainBottomNaveScreen> {

  int _selectedIndex=0;
  final List<Widget>_screens=const[
    NewTaskScreen(),
    ProgressTaskScreen(),
    CompletedTaskScreen(),
    CancelledTaskScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
          onDestinationSelected: (index){
          _selectedIndex=index;
          setState(() {

          });
          },

          destinations: [
            NavigationDestination(icon: Icon(Icons.new_label), label: 'New'),
            NavigationDestination(icon: Icon(Icons.ac_unit_sharp), label: 'Progess'),
            NavigationDestination(icon: Icon(Icons.done), label: 'Complete'),
            NavigationDestination(icon: Icon(Icons.cancel_outlined), label: 'Cancelled'),
          ]
      ),
    );
  }
}