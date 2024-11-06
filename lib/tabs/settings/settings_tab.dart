import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/auth/login_screen.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Logout',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                    onPressed: () {
                      FirebaseFunctions.logout();
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.routeName);
                      Provider.of<TasksProvider>(context, listen: false)
                          .resetData();
                      Provider.of<UserProvider>(context, listen: false)
                          .updateUser(null);
                    },
                    icon: Icon(
                      Icons.logout,
                      size: 30,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
