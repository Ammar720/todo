import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/tabs/tasks/add_task_bottom_sheet.dart';
import 'package:todo/tabs/tasks/edit_task_sheet.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';

class EditTaskScreen extends StatelessWidget {
  static const String routeName = '/edit';
  const EditTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHight = MediaQuery.sizeOf(context).height;
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        title: Text(
                  'ToDO List',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: AppTheme.white),
                ),
                foregroundColor: AppTheme.white,
                titleSpacing: 0,
      ),
        body: Column(
      children: [
        Stack(
          children: [
            Container(
             height: screenHight * 0.05,
              width: double.infinity,
              color: AppTheme.primary,
            ),
            
         Container(
          height: screenHight * 0.5,
          padding: EdgeInsets.all(20),
         child: EditTaskSheet(),
         )
          ],
        ),
      ],
    ),
    );
  }
}
