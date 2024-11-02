import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/tabs/tasks/task_item.dart';
import 'package:todo/widgets/custom_elevated_button.dart';
import 'package:todo/widgets/custom_text_form_field.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  DateTime selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextStyle? titeleMediumStyle = Theme.of(context).textTheme.titleMedium;
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.5,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Text('Add New Task', style: titeleMediumStyle),
              SizedBox(height: 20),
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
              SizedBox(height: 20),
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
              SizedBox(height: 15),
              Text(
                'Select date',
                style: titeleMediumStyle?.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 5),
              InkWell(
                onTap: () async {
                  DateTime? dateTime = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                    initialDate: selectedDate,
                    initialEntryMode: DatePickerEntryMode.calendarOnly,
                  );
                  if (dateTime != null && dateTime != selectedDate) {
                    selectedDate = dateTime;
                  }
                  setState(() {});
                },
                child: Text(
                  dateFormat.format(selectedDate),
                ),
              ),
              SizedBox(height: 30),
              CustomElevatedButton(
                label: 'add',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    addTask();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void addTask() {
    TaskModel task = TaskModel(
      title: titleController.text,
      description: descriptionController.text,
      date: selectedDate,
    );
    FirebaseFunctions.addTaskToFireStore(task).timeout(
      Duration(milliseconds: 100),
      onTimeout: () {
        Navigator.pop(context);
      },
    ).catchError((error) {
      print(error);
    });
  }
}
