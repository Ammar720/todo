import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';
import 'package:todo/widgets/custom_elevated_button.dart';
import 'package:todo/widgets/custom_text_form_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  late String userId;
  @override
  Widget build(BuildContext context) {
    TextStyle? titeleMediumStyle = Theme.of(context).textTheme.titleMedium;
    userId = Provider.of<UserProvider>(context, listen: false).currentUser!.id;

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
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
                Text(AppLocalizations.of(context)!.addNewTask,
                    style: titeleMediumStyle),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: titleController,
                  hintText: AppLocalizations.of(context)!.enterTaskTitle,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppLocalizations.of(context)!.titelCanNotBeEmpty;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: descriptionController,
                  hintText: AppLocalizations.of(context)!.enterTaskDescription,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppLocalizations.of(context)!
                          .descriptionCanNotBeEmpty;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                Text(
                  AppLocalizations.of(context)!.selectDate,
                  style: titeleMediumStyle?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () async {
                    DateTime? dateTime = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
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
                const SizedBox(height: 30),
                CustomElevatedButton(
                  label: AppLocalizations.of(context)!.add,
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
      ),
    );
  }

  void addTask() {
    TaskModel task = TaskModel(
      title: titleController.text,
      description: descriptionController.text,
      date: selectedDate,
    );
    FirebaseFunctions.addTaskToFireStore(task, userId).then(
      (_) {
        if (mounted) {
          Navigator.pop(context);
          Provider.of<TasksProvider>(context, listen: false).getTasks(userId);
        }
        if (mounted) {
          Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.taskaddedSuccessfully,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: AppTheme.green,
          );
        }
      },
    ).catchError((error) {
      if (mounted) {
        Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.somethingWentWorng,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: AppTheme.red,
        );
      }
    });
  }
}
