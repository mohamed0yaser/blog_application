import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      controller: controller,
      decoration:  InputDecoration(
        hintText: hintText,
      ),
      validator: (value){
        if(value!.isEmpty){
          return 'Please enter $hintText';
        }
        return null;
      },
    );
  }
}