import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/auth/login_screen.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/home_screen.dart';
import 'package:todo/widgets/custom_elevated_button.dart';
import 'package:todo/widgets/custom_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';

  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFormField(
                controller: namecontroller,
                hintText: 'Name',
                validator: (value) {
                  if (value == null || value.trim().length < 5) {
                    return 'Name can not be less than 5 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: emailcontroller,
                hintText: 'Email',
                validator: (value) {
                  if (value == null || value.trim().length < 5) {
                    return 'Email can not be less than 5 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: passwordcontroller,
                hintText: 'Password',
                isPassword: true,
                validator: (value) {
                  if (value == null || value.trim().length < 6) {
                    return 'Password can not be less than 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              CustomElevatedButton(label: 'register', onPressed: register),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, LoginScreen.routeName);
                },
                child: const Text('Already have an account'),
              )
            ],
          ),
        ),
      ),
    );
  }

  void register() {
    if (formKey.currentState!.validate()) {
      FirebaseFunctions.register(
        name: namecontroller.text,
        email: emailcontroller.text,
        password: passwordcontroller.text,
      ).then((user) {
        if (mounted) {
          Provider.of<UserProvider>(context, listen: false).updateUser(user);
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        }
      }).catchError(
        (error) {
          String? message;
          if (error is FirebaseAuthException) {
            message = error.message;
          }
          Fluttertoast.showToast(
            msg: message ?? "Something went wrong",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: AppTheme.red,
          );
        },
      );
    }
  }
}
