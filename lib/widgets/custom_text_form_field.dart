import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final bool isPassword;
  
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.isPassword = false,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool isvisible = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  isvisible = !isvisible;
                  setState(() {});
                },
                icon: Icon(isvisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined),
              )
            : null,
      ),
      validator: widget.validator,
      obscureText: isvisible,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
