import 'package:blog_application/core/theme/pallete.dart';
import 'package:blog_application/features/auth/presentation/pages/login_page.dart';
import 'package:blog_application/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_application/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  static route()=> MaterialPageRoute(builder: (context)=> const SignUpPage());
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _formKey.currentState?.validate();
    return  Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,)
              ),
            const SizedBox(height: 10),
             AuthField(hintText: "Username", controller: usernameController,), 
            const SizedBox(height: 10),
             AuthField(hintText: "Email", controller: emailController,),
            const SizedBox(height: 10),
             AuthField(hintText: "Password", controller: passwordController,isPassword: true,),
            const SizedBox(height: 20),
            const AuthGradientButton(text: 'Sign Up',),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  LogInPage.route(),
                );
              },
              child:RichText(text: TextSpan(
              text: 'Already have an account? ',
              style: Theme.of(context).textTheme.titleMedium,
              children: [
                TextSpan(
                  text: 'Login',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Pallete.gradient2,
                    fontWeight: FontWeight.bold,
                  )
                ),
              ],
            ),
            ),
          ),],
          ),
        ),
      )
    );
  }
}