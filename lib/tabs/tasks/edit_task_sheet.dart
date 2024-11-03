import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';
import 'package:todo/widgets/custom_elevated_button.dart';
import 'package:todo/widgets/custom_text_form_field.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditTaskSheet extends StatefulWidget {
  const EditTaskSheet({super.key});

  @override
  State<EditTaskSheet> createState() => _EditTaskSheetState();
}

class _EditTaskSheetState extends State<EditTaskSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  DateTime selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  late String taskId;

  @override
  Widget build(BuildContext context) {
    TextStyle? titeleMediumStyle = Theme.of(context).textTheme.titleMedium;
    TaskModel taskArg = ModalRoute.of(context)!.settings.arguments as TaskModel;
    titleController.text = taskArg.title;
    descriptionController.text = taskArg.description;
    taskId = taskArg.id;
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.5,
      decoration: const BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(15),
          right: Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Text('Edit Task', style: titeleMediumStyle),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: titleController,
                hintText: 'Enter task title',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Titel can not be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: descriptionController,
                hintText: 'Enter task description',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Description can not be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              Text(
                'selected date',
                style: titeleMediumStyle?.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 5),
              InkWell(
                onTap: () async {
                  DateTime? dateTime = await showDatePicker(
                    context: context,
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 365)),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    initialDate: taskArg.date,
                    initialEntryMode: DatePickerEntryMode.calendarOnly,
                  );
                  if (dateTime != null && dateTime != selectedDate) {
                    setState(() {
                      selectedDate = dateTime;
                    });
                  }
                },
                child: Text(
                  dateFormat.format(selectedDate),
                ),
              ),
              const SizedBox(height: 30),
              CustomElevatedButton(
                label: 'save changes',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    updateTask();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void updateTask() {
    TaskModel task = TaskModel(
      title: titleController.text,
      description: descriptionController.text,
      date: selectedDate,
      id: taskId,
    );
    FirebaseFunctions.updateTaskDataInFireStore(task).timeout(
      const Duration(milliseconds: 100),
      onTimeout: () {
        Navigator.pop(context);
        Provider.of<TasksProvider>(context, listen: false).getTasks();
        Fluttertoast.showToast(
          msg: "Task updated successfully",
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
  }
}
