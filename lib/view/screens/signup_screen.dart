import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Center(
            child: Text("Signup Screen"),
          ),
        ),
      ),
    );
  }
}
