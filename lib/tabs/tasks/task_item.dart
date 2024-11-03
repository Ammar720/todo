import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/tabs/tasks/edit_task_screen.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';

class TaskItem extends StatefulWidget {
  TaskModel task;
  TaskItem({super.key, required this.task});
  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    Color taskColor = widget.task.isDone ? AppTheme.green : AppTheme.primary;
    return InkWell(
      onTap: () => {
        Navigator.pushNamed(context, EditTaskScreen.routeName,
            arguments: widget.task),
      },
      child: Container(
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
                  FirebaseFunctions.deleteTaskToFireStore(widget.task.id)
                      .timeout(
                    const Duration(milliseconds: 100),
                    onTimeout: () {
                      Provider.of<TasksProvider>(context, listen: false)
                          .getTasks();
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
                  decoration: BoxDecoration(color: taskColor),
                  margin: const EdgeInsetsDirectional.only(end: 12),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: taskColor),
                    ),
                    Text(
                      widget.task.description,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: () async {
                    setState(() {
                      widget.task.isDone = !widget.task.isDone;
                    });
                    await FirebaseFunctions.updateTaskStateInFireStore(
                      widget.task.id,
                      widget.task.isDone,
                    ).then((_) {
                      Provider.of<TasksProvider>(context, listen: false)
                          .getTasks();
                      Fluttertoast.showToast(
                        msg: "Task updated successfully",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 5,
                        backgroundColor: AppTheme.green,
                      );
                    }).catchError((error) {
                      Fluttertoast.showToast(
                        msg: "Something went wrong",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 5,
                        backgroundColor: AppTheme.red,
                      );
                      setState(() {
                        widget.task.isDone = !widget.task.isDone;
                      });
                    });
                  },
                  child: widget.task.isDone
                      ? const Text(
                          'Done!',
                          style: TextStyle(
                              color: AppTheme.green,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        )
                      : Container(
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
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
