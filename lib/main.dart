import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/home_screen.dart';

void main() {
  runApp(const Todo());
}

class Todo extends StatelessWidget {
  const Todo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName : (context) => HomeScreen()
      },

      initialRoute: HomeScreen.routeName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode:ThemeMode.light,

    );
  }
}
