import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/tabs/tasks/edit_task_sheet.dart';

class EditTaskScreen extends StatelessWidget {
  static const String routeName = '/edit';
  const EditTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHight = MediaQuery.sizeOf(context).height;

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
          padding: const EdgeInsets.all(20),
         child: const EditTaskSheet(),
         )
          ],
        ),
      ],
    ),
    );
  }
}
