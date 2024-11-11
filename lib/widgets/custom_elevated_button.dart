import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
 final String label;
 final VoidCallback onPressed;
  const CustomElevatedButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.sizeOf(context).width, 52),
      ),
      child: Text(label , style: const TextStyle(fontSize: 21),),
    );
  }
}
