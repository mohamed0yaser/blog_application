import 'package:blog_application/core/theme/pallete.dart';
import 'package:blog_application/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_application/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_application/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';

class LogInPage extends StatefulWidget {
  static route()=> MaterialPageRoute(builder: (context)=> const LogInPage());
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _formKey.currentState?.validate();
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Log In',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 10),
            AuthField(
              hintText: "Email",
              controller: emailController,
            ),
            const SizedBox(height: 10),
            AuthField(
              hintText: "Password",
              controller: passwordController,
              isPassword: true,
            ),
            const SizedBox(height: 20),
            const AuthGradientButton(text: 'Log In',),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  SignUpPage.route(),
                );
              },
              child: RichText(
                text: TextSpan(
                  text: 'don\'t have an account? ',
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    TextSpan(
                        text: 'Sign Up',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Pallete.gradient2,
                              fontWeight: FontWeight.bold,
                            )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
