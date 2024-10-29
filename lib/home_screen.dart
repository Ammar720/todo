import 'package:flutter/material.dart';
import 'package:todo/tabs/settings/settings_tab.dart';
import 'package:todo/tabs/tasks/tasks_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [
    const TasksTab(),
    const SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        padding: EdgeInsets.zero,
        notchMargin: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: const CircularNotchedRectangle(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BottomNavigationBar(
              onTap: (index) => {currentIndex = index, setState(() {})},
              currentIndex: currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined),
                  label: 'Settings',
                )
              ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
          size: 33,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
