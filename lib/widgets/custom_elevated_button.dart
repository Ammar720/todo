import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  String label;
  VoidCallback onPressed;
  CustomElevatedButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.sizeOf(context).width, 52),
      ),
      child: Text(label , style: TextStyle(fontSize: 21),),
    );
  }
}
