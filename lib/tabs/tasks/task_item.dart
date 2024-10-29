import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/models/task_model.dart';

class TaskItem extends StatelessWidget {
  TaskModel task;
  TaskItem({super.key, required this.task});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppTheme.white,
      ),
      child: Row(
        children: [
          Container(
            height: 62,
            width: 4,
            decoration: BoxDecoration(color: AppTheme.primary),
            margin: EdgeInsetsDirectional.only(end: 12),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: AppTheme.primary),
              ),
              Text(
                task.description,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          Spacer(),
          Container(
            width: 69,
            height: 34,
            decoration: BoxDecoration(
              color: AppTheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.check,
              color: AppTheme.white,
              size: 30,
            ),
          )
        ],
      ),
    );
  }
}
