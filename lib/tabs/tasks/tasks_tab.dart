import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/tabs/tasks/task_item.dart';

class TasksTab extends StatelessWidget {
  List<TaskModel> tasks = List.generate(
    10,
    (index) => TaskModel(
      title: 'title $index',
      description: 'description $index',
      date: DateTime.now(),
    ),
  );
  @override
  Widget build(BuildContext context) {
    double screenHight = MediaQuery.sizeOf(context).height;
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: screenHight * 0.17,
              width: double.infinity,
              color: AppTheme.primary,
            ),
            PositionedDirectional(
              start: 20,
              top: screenHight * 0.01,
              child: SafeArea(
                child: Text(
                  'ToDO List',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: AppTheme.white),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHight * 0.12),
              child: EasyInfiniteDateTimeLine(
                firstDate: DateTime.now().subtract(const Duration(days: 365)),
                focusDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                showTimelineHeader: false,
                dayProps: EasyDayProps(
                  height: 79,
                  width: 58,
                  dayStructure: DayStructure.dayStrDayNum,
                  activeDayStyle: DayStyle(
                    dayNumStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                    ),
                    dayStrStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: AppTheme.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            spreadRadius: 4,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ]),
                  ),
                  inactiveDayStyle: DayStyle(
                    dayNumStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.black,
                    ),
                    dayStrStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.black,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: AppTheme.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 20),
            itemBuilder: (context, index) => TaskItem(task: tasks[index],),
            itemCount: tasks.length,
          ),
        ),
      ],
    );
  }
}
