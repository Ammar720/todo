import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';

class TaskItem extends StatelessWidget {
  TaskModel task;
  TaskItem({super.key, required this.task});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                FirebaseFunctions.deleteTaskToFireStore(task.id).timeout(
                  const Duration(milliseconds: 100),
                  onTimeout: () {
                    Provider.of<TasksProvider>(context , listen: false).getTasks();
                    Fluttertoast.showToast(
                      msg: "Task deleted successfully",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 5,
                      backgroundColor: AppTheme.green,
                    );
                  },
                ).catchError((error) {
                  Fluttertoast.showToast(
                    msg: "Something went worng",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 5,
                    backgroundColor: AppTheme.red,
                  );
                });
              },
              backgroundColor: AppTheme.red,
              foregroundColor: AppTheme.white,
              borderRadius: BorderRadius.circular(15),
              icon: Icons.delete,
              label: 'Delete',
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppTheme.white,
          ),
          child: Row(
            children: [
              Container(
                height: 62,
                width: 4,
                decoration: const BoxDecoration(color: AppTheme.primary),
                margin: const EdgeInsetsDirectional.only(end: 12),
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
              const Spacer(),
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
        ),
      ),
    );
  }
}
