import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/auth/login_screen.dart';
import 'package:todo/auth/register_screen.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/home_screen.dart';
import 'package:todo/tabs/tasks/edit_task_screen.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TasksProvider(),
        ),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: const Todo(),
    ),
  );
}

class Todo extends StatelessWidget {
  const Todo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        EditTaskScreen.routeName: (context) => const EditTaskScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen()
      },
      initialRoute: LoginScreen.routeName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}
