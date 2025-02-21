import 'package:blog_application/core/theme/pallete.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  final String text;
  const AuthGradientButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Pallete.gradient1,
            Pallete.gradient2
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: (){},
        style: ElevatedButton.styleFrom(
          backgroundColor:Pallete.transparentColor ,
          shadowColor: Pallete.transparentColor,
          fixedSize: const Size(400, 55),
          ),
        child: Text(text),
        ),
    );
  }
}